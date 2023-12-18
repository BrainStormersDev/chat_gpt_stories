import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts= FlutterTts();
  String textToRead = "Hello Flutter World! package:flutter_tts/flutter_tts.dart";
  List<String> words=[];
  int currentWordIndex = 0;
  double speechRate = 0.5; // Adjust the rate as needed
  TtsState ttsState = TtsState.stopped;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    words = textToRead.split(" ");
  }

  Future<void> speakWordByWord() async {
    for (var i = currentWordIndex; i < words.length; i++) {
      String word = words[i];
      await flutterTts.setSpeechRate(speechRate);
      await flutterTts.speak(word);
      await Future.delayed(Duration(seconds: 1)); // Adjust the duration as needed
      setState(() {
        currentWordIndex = i + 1;
      });
    }
    setState(() {
      ttsState = TtsState.stopped;
    });
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
              words.take(currentWordIndex).join(" "),
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (ttsState == TtsState.stopped) {
                  speakWordByWord();
                  setState(() {
                    ttsState = TtsState.playing;
                  });
                }
              },
              child: Text(
                'Start Speaking',
              ),
            ),
          ],
        ),
      ),
    );
  }}
