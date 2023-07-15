import 'package:flutter/material.dart';
import 'package:alphabet_text_to_speech/alphabets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HindiHelpScreen extends StatelessWidget {
  final List<String> hindiAlphabets = Alphabets.hindiAlphabets;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('hi-IN');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hindi Alphabets - बारहखड़ी'),
      ),
      body: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(16.0),
        children: hindiAlphabets.map((alphabet) {
          return GestureDetector(
            onTap: () => speak(alphabet),
            child: Card(
              child: Center(
                child: Text(
                  alphabet,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
