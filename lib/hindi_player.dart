import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';
import 'alphabets.dart';
import 'hindi_help_screen.dart';

class HindiPlayer extends StatefulWidget {
  @override
  _HindiPlayerState createState() => _HindiPlayerState();
}

class _HindiPlayerState extends State<HindiPlayer> {
  final TextEditingController repeatCountController = TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  String currentAlphabet = '';
  bool isPlaying = false;
  String selectedStartAlphabet = Alphabets.hindiAlphabets.first;
  String selectedEndAlphabet = Alphabets.hindiAlphabets.first;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage('hi');
    flutterTts.setSpeechRate(0.4);
  }

  @override
  void deactivate()  async{
    await flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('hi-IN');
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

  void playHindiAlphabets() async {
    final int repeatCount = int.parse(repeatCountController.text);

    if (repeatCount > 0) {

      setState(() {
        isPlaying = true;
      });

      for (int i = 0; i < repeatCount && isPlaying; i++) {
        final startIndex = Alphabets.hindiAlphabets.indexOf(selectedStartAlphabet);
        final endIndex = Alphabets.hindiAlphabets.indexOf(selectedEndAlphabet);

        for (int j = startIndex; mounted && isPlaying && j <= endIndex; j++) {
          final currentAlphabet = Alphabets.hindiAlphabets[j];
          await playAlphabet(currentAlphabet);
          await Future.delayed(
              Duration(milliseconds: 2000)); // Delay for 2 seconds
        }
      }

      if(mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        stop(); // Call the stop() method before navigating back
        return true; // Allow the back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hindi Player'),
          actions: [
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HindiHelpScreen()),
                );
              },
            ),
          ]
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
                  items: Alphabets.hindiAlphabets.map((alphabet) {
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
                  items: Alphabets.hindiAlphabets.map((alphabet) {
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
                      onPressed: isPlaying ? null : playHindiAlphabets,
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
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
