import 'package:alphabet_text_to_speech/alphabets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class EnglishPlayer extends StatefulWidget {
  @override
  _EnglishPlayerState createState() => _EnglishPlayerState();
}

class _EnglishPlayerState extends State<EnglishPlayer> {
  final TextEditingController repeatCountController =
      TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  String currentAlphabet = '';
  bool isPlaying = false;
  String selectedStartAlphabet = Alphabets.englishAlphabets.first;
  String selectedEndAlphabet = Alphabets.englishAlphabets.last;

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
        final startIndex =
            Alphabets.englishAlphabets.indexOf(selectedStartAlphabet);
        final endIndex =
            Alphabets.englishAlphabets.indexOf(selectedEndAlphabet);

        for (int j = startIndex; mounted && j <= endIndex && isPlaying; j++) {
          final currentAlphabet = Alphabets.englishAlphabets[j];
          await playAlphabet(currentAlphabet);
          await Future.delayed(
              Duration(milliseconds: 2000)); // Delay for 2 seconds
        }
      }

      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  @override
  void deactivate() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Alphabet Player'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              shrinkWrap: true,
              children: Alphabets.englishAlphabets.map((alphabet) {
                return Container(
                    margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => playAlphabet(alphabet),
                      child: Text(alphabet),
                    ));
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
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
                ),
                Expanded(
                  child: DropdownButtonFormField<String>(
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
                ),
                Expanded(
                  child: TextField(
                    controller: repeatCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Repeat Count',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isPlaying ? stop : playLessonString,
                  child: isPlaying ? Text('Stop') : Text('Play'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 200.0,
            child: Text(
              currentAlphabet,
              style: TextStyle(
                fontSize: 180,
                fontWeight: FontWeight.bold,
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
