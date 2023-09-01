// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
//
//
//
// class TextToSpeechWidget extends StatefulWidget {
//   @override
//   _TextToSpeechWidgetState createState() => _TextToSpeechWidgetState();
// }
//
// class _TextToSpeechWidgetState extends State<TextToSpeechWidget> {
//   final FlutterTts flutterTts = FlutterTts();
//
//   String paragraph =
//       "When winter came, the villagers had no food to eat, but the sparrow shared his seeds with them. The villagers were grateful and thanked the sparrow for his kindness. From that day on, the sparrow was known as the kindest bird in the village.";
//
//   List<String> words = [];
//   int currentWordIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     words = paragraph.split(" ");
//     flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
//       currentWordIndex = words.indexOf(word);
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     flutterTts.stop();
//     super.dispose();
//   }
//
//   void speakParagraph() async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setSpeechRate(0.5); // Adjust speech rate (0.0 to 1.0)
//     await flutterTts.setPitch(1.0); // Adjust pitch (0.5 to 2.0)
//     for (int i = 0; i < words.length; i++) {
//       await flutterTts.speak(words[i]);
//       // Wait for the current word to be spoken before speaking the next one
//       await Future.delayed(const Duration(milliseconds: 500));
//     }
//   }
//
//   // TextStyle _getWordTextStyle(int index) {
//   //   if (index == currentWordIndex) {
//   //     return const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue);
//   //   }
//   //   return const TextStyle();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height:200,
//               child: SingleChildScrollView
//                 (
//                 child: Text(
//                   words.map((word) => word).join(" "),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 18.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: speakParagraph,
//               child: Text('Speak Paragraph'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

String text = '''
  In this updated code, the paragraph is split into words, and each word is displayed as a separate TextSpan in a RichText widget. As the words are spoken one by one, the corresponding word's background color changes to yellow while the remaining words are displayed in grey.
  Remember to replace the placeholder text with your actual 200-word paragraph and customize the colors and styles as needed. Also, make sure to have the flutter_tts dependency added to your pubspec.yaml file as shown in the previous response.
  ''';
class SpeechHighlightedText extends StatefulWidget {
  @override
  _SpeechHighlightedTextState createState() => _SpeechHighlightedTextState();
}

class _SpeechHighlightedTextState extends State<SpeechHighlightedText> {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  late List<String> words;
  int spokenWordIndex = 0;
  String speakingindex="";

  // String text = "Your paragraph of 200 words goes here...";
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    toggleSpeaking();
  }
  void toggleSpeaking() {
    setState(() {
      isSpeaking = !isSpeaking;
      if (isSpeaking) {
        words = text.split(" ");
        spokenWordIndex = 0;
        _speakWord();
      } else {
        flutterTts.stop();
      }
    });
  }

  Future<void> _speakWord() async {
    if (spokenWordIndex < words.length) {
      await flutterTts.speak(words[spokenWordIndex]);
       flutterTts.setProgressHandler((text, start, end, word) {

         speakingindex=word;

       });
      setState(() {
        spokenWordIndex++;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        _speakWord();
      });
    } else {
      setState(() {
        isSpeaking = false;
      });
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  words.indexWhere((element) => false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech Highlighted Text"),
      ),
      body:
      false?
          Text(text,style: TextStyle(  backgroundColor:     Colors.red),):
      Center(
        child: RichText(
          text: TextSpan(
            children: words.map<InlineSpan>((word) {
              print("=============== words.indexOf(word) ${word}  speakingindex $spokenWordIndex");
              words.indexWhere((element) => element==speakingindex);
              // bool isSpoken = (words.indexOf(word) < spokenWordIndex) && (word==speakingindex) ;
              bool isSpoken = word == words.indexWhere((element) => element==speakingindex) ;
              return TextSpan(
                text: "$word ",
                style: TextStyle(
                  color:  Colors.black,
                  backgroundColor: isSpoken ? Colors.yellow : Colors.transparent,
                  // backgroundColor: (words.indexOf(word) == spokenWordIndex)? Colors.yellow : Colors.transparent,
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleSpeaking,
        child: Icon(isSpeaking ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
///set
// class SpeechHighlightedText extends StatefulWidget {
//   @override
//   _SpeechHighlightedTextState createState() => _SpeechHighlightedTextState();
// }
//
// class _SpeechHighlightedTextState extends State<SpeechHighlightedText> {
//   FlutterTts flutterTts = FlutterTts();
//   bool isSpeaking = false;
//   late List<String> words;
//   int spokenWordIndex = 0;
//
//
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     toggleSpeaking();
//   }
//   void toggleSpeaking() {
//     setState(() {
//       isSpeaking = !isSpeaking;
//       if (isSpeaking) {
//         words = text.split(" ");
//         spokenWordIndex = 0;
//         _speakWord();
//       } else {
//         flutterTts.stop();
//       }
//     });
//   }
//
//   Future<void> _speakWord() async {
//     if (spokenWordIndex < words.length) {
//       await flutterTts.speak(words[spokenWordIndex]);
//       setState(() {
//         spokenWordIndex++;
//       });
//       Future.delayed(const Duration(milliseconds: 500), () {
//         _speakWord();
//       });
//     } else {
//       setState(() {
//         isSpeaking = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     flutterTts.stop();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Speech Highlighted Text"),
//       ),
//       body: Center(
//         child: RichText(
//           text: TextSpan(
//             children: words.map<InlineSpan>((word) {
//               bool isSpoken = words.indexOf(word) < spokenWordIndex;
//               return TextSpan(
//                 text: "$word ",
//                 style: TextStyle(
//                   // color: isSpoken ? Colors.grey : Colors.black,
//                   backgroundColor: isSpoken ? Colors.yellow : Colors.white,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: toggleSpeaking,
//         child: Icon(isSpeaking ? Icons.stop : Icons.play_arrow),
//       ),
//     );
//   }
// }
//

