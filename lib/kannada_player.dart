import 'package:alphabet_text_to_speech/alphabets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class KannadaPlayer extends StatefulWidget {
  @override
  _KannadaPlayerState createState() => _KannadaPlayerState();
}

class _KannadaPlayerState extends State<KannadaPlayer> {
  final TextEditingController startAlphabetController =
  TextEditingController(text: Alphabets.kannadaAlphabets.first);
  final TextEditingController endAlphabetController =
  TextEditingController(text: Alphabets.kannadaAlphabets.last);
  final TextEditingController repeatCountController =
      TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  String currentAlphabet = '';
  bool isPlaying = false;

  List<String> kannadaAlphabets = Alphabets.kannadaAlphabets;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage('kn-IN');
    flutterTts.setSpeechRate(0.4);
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('kn-IN');
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
    final String startAlphabet = startAlphabetController.text;
    final String endAlphabet = endAlphabetController.text;
    final int repeatCount = int.parse(repeatCountController.text);

    if (startAlphabet.isNotEmpty && endAlphabet.isNotEmpty && repeatCount > 0) {
      setState(() {
        isPlaying = true;
      });

      for (int i = 0; i < repeatCount && isPlaying; i++) {
        final startIndex = kannadaAlphabets.indexOf(startAlphabet);
        final endIndex = kannadaAlphabets.indexOf(endAlphabet);

        for (int j = startIndex; isPlaying && j <= endIndex; j++) {
          final currentAlphabet = kannadaAlphabets[j];
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
        title: Text('Kannada Player'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<String>(
                value: startAlphabetController.text,
                onChanged: (newValue) {
                  setState(() {
                    startAlphabetController.text = newValue!;
                  });
                },
                items: kannadaAlphabets.map((alphabet) {
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
                value: endAlphabetController.text,
                onChanged: (newValue) {
                  setState(() {
                    endAlphabetController.text = newValue!;
                  });
                },
                items: kannadaAlphabets.map((alphabet) {
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
                    child: Text('Play'),
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
