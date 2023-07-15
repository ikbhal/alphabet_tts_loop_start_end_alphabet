import 'package:flutter/material.dart';
import 'package:alphabet_text_to_speech/alphabets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class KannadaHelpScreen extends StatelessWidget {
  final List<String> kannadaAlphabets = Alphabets.kannadaAlphabets;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('kn-IN');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kannada Alphabets ಕನ್ನಡ ಅಕ್ಷರಮಾಲೆ'),
      ),
      body: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(16.0),
        children: kannadaAlphabets.map((alphabet) {
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
