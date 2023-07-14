import 'package:alphabet_text_to_speech/alphabets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class EnglishAlphabetPlayer extends StatefulWidget {
  @override
  _EnglishAlphabetPlayerState createState() => _EnglishAlphabetPlayerState();
}

class _EnglishAlphabetPlayerState extends State<EnglishAlphabetPlayer> {
  final TextEditingController startAlphabetController =
  TextEditingController(text:Alphabets.englishAlphabets.first);
  final TextEditingController endAlphabetController =
  TextEditingController(text:Alphabets.englishAlphabets.first);
  final TextEditingController repeatCountController =
      TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  String currentAlphabet = '';
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage('en');
    flutterTts.setSpeechRate(0.4);
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void stop() async {
    if (mounted && isPlaying) {
      await flutterTts.stop();
      setState(() {
        isPlaying = false;
      });
    }
  }

  Future<bool> playAlphabet(String alphabet) async {
    // Set the current alphabet
    setState(() {
      currentAlphabet = alphabet;
    });

    // Speak the current alphabet
    await speak(alphabet);

    return true;
  }

  void playLessonString() async {
    final String startAlphabet = startAlphabetController.text.toUpperCase();
    final String endAlphabet = endAlphabetController.text.toUpperCase();
    final int repeatCount = int.parse(repeatCountController.text);

    if (startAlphabet.isNotEmpty && endAlphabet.isNotEmpty && repeatCount > 0) {
      setState(() {
        isPlaying = true;
      });

      final random = Random();

      for (int i = 0; i < repeatCount && isPlaying; i++) {
        for (int j = startAlphabet.codeUnitAt(0);
            isPlaying && j <= endAlphabet.codeUnitAt(0);
            j++) {
          final currentAlphabet = String.fromCharCode(j);
          await playAlphabet(currentAlphabet);
          await Future.delayed(
              Duration(milliseconds: 2000)); // Delay for 2 seconds
        }
      }

      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Alphabet Player'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: startAlphabetController,
                maxLength: 1,
                decoration: InputDecoration(
                  labelText: 'Start Alphabet',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: endAlphabetController,
                maxLength: 1,
                decoration: InputDecoration(
                  labelText: 'End Alphabet',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: repeatCountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Repeat Count',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: isPlaying ? null : playLessonString,
                child: Text('Speak'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: stop,
                child: Text('Stop'),
              ),
              SizedBox(height: 20.0),
              Text(
                currentAlphabet,
                style: TextStyle(
                  fontSize: 180,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
