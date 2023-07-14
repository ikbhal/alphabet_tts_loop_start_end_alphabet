import 'package:alphabet_text_to_speech/alphabets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class EnglishAlphabetPlayer extends StatefulWidget {
  @override
  _EnglishAlphabetPlayerState createState() => _EnglishAlphabetPlayerState();
}

class _EnglishAlphabetPlayerState extends State<EnglishAlphabetPlayer> {
  final TextEditingController repeatCountController =
  TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  String currentAlphabet = '';
  bool isPlaying = false;
  String selectedStartAlphabet = Alphabets.englishAlphabets.first;
  String selectedEndAlphabet = Alphabets.englishAlphabets.first;

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
    if (isPlaying) {
      await flutterTts.stop();
      setState(() {
        isPlaying = false;
      });
    }
  }

  Future<bool> playAlphabet(String alphabet) async {
    setState(() {
      currentAlphabet = alphabet;
    });
    await speak(alphabet);
    return true;
  }

  void playLessonString() async {
    final int repeatCount = int.parse(repeatCountController.text);

    if (repeatCount > 0) {
      setState(() {
        isPlaying = true;
      });

      for (int i = 0; i < repeatCount && isPlaying; i++) {
        final startIndex = Alphabets.englishAlphabets.indexOf(selectedStartAlphabet);
        final endIndex = Alphabets.englishAlphabets.indexOf(selectedEndAlphabet);

        for (int j = startIndex; j <= endIndex && isPlaying; j++) {
          final currentAlphabet = Alphabets.englishAlphabets[j];
          await playAlphabet(currentAlphabet);
          await Future.delayed(Duration(milliseconds: 2000)); // Delay for 2 seconds
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
              DropdownButtonFormField<String>(
                value: selectedStartAlphabet,
                onChanged: (newValue) {
                  setState(() {
                    selectedStartAlphabet = newValue!;
                  });
                },
                items: Alphabets.englishAlphabets.map((alphabet) {
                  return DropdownMenuItem(
                    value: alphabet,
                    child: Text(alphabet),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Start Alphabet',
                ),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                value: selectedEndAlphabet,
                onChanged: (newValue) {
                  setState(() {
                    selectedEndAlphabet = newValue!;
                  });
                },
                items: Alphabets.englishAlphabets.map((alphabet) {
                  return DropdownMenuItem(
                    value: alphabet,
                    child: Text(alphabet),
                  );
                }).toList(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isPlaying ? null : playLessonString,
                    child: Text('Speak'),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: stop,
                    child: Text('Stop'),
                  ),
                ],
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
