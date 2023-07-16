import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MonthScreen extends StatefulWidget {
  final String month;

  MonthScreen({required this.month});

  @override
  _MonthScreenState createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  FlutterTts flutterTts = FlutterTts();
  List<String> letters = [];
  int currentLetterIndex = 0;
  String currentWord = '';
  Timer? timer;
  final random = Random();

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
    final word = widget.month.toUpperCase();
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
        speakLetter(widget.month.toUpperCase());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Month Screen'),
      ),
      body: Center(
        child: Text(
          currentWord,
          style: TextStyle(
            fontSize: currentWord.length == 1 ? 300 : 50,
            color: Colors.primaries[random.nextInt(Colors.primaries.length)],
            fontWeight:
                currentWord.length > 1 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
