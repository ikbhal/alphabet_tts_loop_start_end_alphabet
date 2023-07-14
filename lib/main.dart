import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final FlutterTts tts = FlutterTts();
  final TextEditingController controller =
  TextEditingController(text: 'Hello world');

  final TextEditingController repeatedController = TextEditingController(text: '10');

  Home() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }

  String fillStringWithAlphabets(String startAlphabet, String endAlphabet) {
    // Convert start and end alphabets to uppercase
    startAlphabet = startAlphabet.toUpperCase();
    endAlphabet = endAlphabet.toUpperCase();

    // Get the ASCII code of the start and end alphabets
    int startCode = startAlphabet.codeUnitAt(0);
    int endCode = endAlphabet.codeUnitAt(0);

    // Create an empty string
    String filledString = '';

    // Iterate through the ASCII codes of the alphabets
    for (int i = startCode; i <= endCode; i++) {
      // Convert the ASCII code back to an alphabet character
      String alphabet = String.fromCharCode(i);

      // Add the alphabet character to the filled string
      filledString += alphabet;
    }

    return filledString;
  }


  String getRandomAlphabet() {
    final random = Random();
    final startCode = 'A'.codeUnitAt(0);
    final endCode = 'Z'.codeUnitAt(0);
    final randomCode = startCode + random.nextInt(endCode - startCode + 1);
    return String.fromCharCode(randomCode);
  }

  // String getRepeatedString(String originalString, int repeat=100) {
  //   // String originalString = "Hello, world!";
  //   String repeatedString = originalString * 100;
  //   return repeatedString;
  // }

  String repeatString(String inputString, {int repeatCount = 20}) {
    return inputString * repeatCount;
  }

  void main() {
    String startAlphabet = 'A';
    String endAlphabet = 'F';

    String filledString = fillStringWithAlphabets(startAlphabet, endAlphabet);
    print(filledString); // Output: ABCDEF
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Text',
            ),
          ),
          TextField(
            controller: repeatedController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Repeat Count',
            ),
          ),
          ElevatedButton(
              onPressed: (){
                // controller.text= "abcdefghijklmnopqrstuvwxyz";

                String startAlphabet = "a";
                String endAlphabet = "z";
                endAlphabet = getRandomAlphabet();
                String lessonText= fillStringWithAlphabets(startAlphabet, endAlphabet);
                print("startAlphabet: $startAlphabet, endAlphabet: $endAlphabet , Lesson Text: $lessonText ");
                String repeatCountString = repeatedController.text;
                int repeatCount = int.parse(repeatCountString);
                print('Repeat count: $repeatCount');
                String repeatedText = repeatString(lessonText, repeatCount: repeatCount);
                controller.text = repeatedText;
              },
              child: Text("Fill Lesson Text")),
          ElevatedButton(
              onPressed: () {
                tts.speak(controller.text);
              },
              child: Text('Speak')),

          ElevatedButton(
              onPressed: () {
                tts.stop();
              },
              child: Text('Stop'))
        ],
      ),
    );
  }
}