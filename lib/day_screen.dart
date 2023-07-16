import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DayScreen extends StatefulWidget {
  final String day;

  DayScreen({required this.day});

  @override
  _DayScreenState createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  FlutterTts flutterTts = FlutterTts();
  List<String> letters = [];
  int currentLetterIndex = 0;
  String currentWord ='';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    initializeLetters();
    flutterTts.setLanguage('en-US');
    flutterTts.setSpeechRate(0.4);
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void initializeLetters() {
    final word = widget.day.toUpperCase();
    letters = word.split('');
  }

  void speakLetter(String letter) async {
    await flutterTts.speak(letter);
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (currentLetterIndex < letters.length) {
        final letter = letters[currentLetterIndex];
        speakLetter(letter);
        setState(() {
          currentWord = letters[currentLetterIndex].toUpperCase();
          currentLetterIndex++;
        });
      } else {
        timer.cancel();
        setState(() {
          currentWord = letters.join().toUpperCase();
        });
        speakLetter(widget.day.toUpperCase());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day),
      ),
      body: Center(
        child: Text(
          // letters.take(currentLetterIndex).join(),
          currentWord,
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}
