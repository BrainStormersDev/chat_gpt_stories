import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = FlutterTts();
  String paragraph="Once upon a time, in a dense forest, there lived a variety of animals. Each day, they went about their business, gathering food, playing, and taking care of their young. The animals were all different, with their own unique abilities and personalities.\nThere was a wise old owl who lived in a tree and spent her days watching over the forest and its inhabitants. She was known for her knowledge and was often asked for advice.\nThere was a sly fox who was always up to something. He loved to play pranks on his friends and was always the life of the party. But despite his mischievous nature, he had a good heart and was always there to help when someone was in need.\nThere was also a strong and brave bear who lived in a cave near the river. He spent his days fishing and taking care of his family. He was fiercely protective of his territory and would do anything to keep his loved ones safe.\nAlong with the owl, fox, and bear, there were many other animals in the forest, including rabbits, deer, squirrels, and even a family of beavers who built dams and lodges.\nOne day, a hunter came into the forest with the intention of catching and selling the animals. The animals were frightened and didn't know what to do. But, the owl came up with a plan to outsmart the hunter.\nThe animals all worked together and created a big noise, making the hunter believe that a fierce beast was on the loose in the forest. The hunter ran out of the forest as fast as he could, and the animals were safe once again.\nFrom then on, the animals learned to stick together and look out for each other, no matter what challenges they may face. And they lived happily ever after, in their beautiful and peaceful forest home.\nThe end.";
  List<String> lines = [

  ];
  int currentIndex = 0;
  List<String> _words = [];

  @override
  void initState() {
    super.initState();
    lines=paragraph.split(".");
    _speakLines();
  }

  int displayIndex = 0;
  int fullSentenceIndex = 0;
  String displayText = '';
  List<String> display = [];

  void _playTextWithDelay(String line) {
    displayIndex = 0;
    _words = line.split(' ');
    const Duration wordDelay = const Duration(milliseconds: 300);
    Future<void> playWord(int index) async {
      await Future.delayed(wordDelay);
      setState(() {
        displayIndex = index;
        displayText = _words.take(displayIndex).join(' ');
        display.add(displayText);
        // display[fullSentenceIndex]=displayText;
      });
      if (index < _words.length) {
        await playWord(index + 1);
      }
    }
    playWord(displayIndex);
  }
  Future<void> _speakLines() async {
    if (currentIndex < lines.length) {
      String line = lines[currentIndex];
      _words = line.split(' ');
      // displayText+=line+". ";

      _playTextWithDelay(line);
       // Adjust this delay as needed
      await flutterTts.speak(line);
      fullSentenceIndex+1;
      print('dfgggggggggggggggggfffffffgfgggggfffffffffffffffff');
      await Future.delayed(
          Duration(milliseconds:300 * (_words.length + 1)));
      currentIndex++;
      if (currentIndex < lines.length) {
        // await Future.delayed(Duration(seconds: 2)); // Delay between lines
        _speakLines();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text-to-Speech Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lines:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(children: [
              Text(displayText),
            if(fullSentenceIndex>0)
              Container(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,

                  itemCount: fullSentenceIndex,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        display[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),

            ]),
          ],
        ),
      ),
    );
  }
}
