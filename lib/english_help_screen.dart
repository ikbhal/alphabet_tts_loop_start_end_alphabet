import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EnglishHelpScreen extends StatelessWidget {
  final List<String> alphabets = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakAlphabet(String alphabet) async {
    await flutterTts.speak(alphabet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Help'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: alphabets.length,
        itemBuilder: (context, index) {
          final alphabet = alphabets[index];
          return GestureDetector(
            onTap: () => speakAlphabet(alphabet),
            child: Card(
              child: Center(
                child: Text(
                  alphabet,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
