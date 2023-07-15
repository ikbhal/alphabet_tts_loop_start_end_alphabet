import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumberHelpScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakNumber(int number) async {
    await flutterTts.speak(number.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: 51,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => speakNumber(index),
            child: Card(
              child: Center(
                child: Text(
                  index.toString(),
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
