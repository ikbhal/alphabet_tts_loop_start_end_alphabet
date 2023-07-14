import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AlphabetPlayer(),
    );
  }
}

class AlphabetPlayer extends StatefulWidget {
  @override
  _AlphabetPlayerState createState() => _AlphabetPlayerState();
}

class _AlphabetPlayerState extends State<AlphabetPlayer> {
  final TextEditingController startAlphabetController = TextEditingController();
  final TextEditingController endAlphabetController = TextEditingController();
  final TextEditingController repeatCountController = TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  String lessonString = '';
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    // flutterTts = FlutterTts();
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

  void playLessonString() {
    final String startAlphabet = startAlphabetController.text.toUpperCase();
    final String endAlphabet = endAlphabetController.text.toUpperCase();
    final int repeatCount = int.parse(repeatCountController.text);

    if (startAlphabet.isNotEmpty && endAlphabet.isNotEmpty && repeatCount > 0) {
      setState(() {
        isPlaying = true;
      });

      String lesson = '';
      for (int i = 0; i < repeatCount; i++) {
        lesson += startAlphabet + ' ';
        for (int j = startAlphabet.codeUnitAt(0) + 1; j <= endAlphabet.codeUnitAt(0); j++) {
          lesson += String.fromCharCode(j) + ' ';
        }
      }

      setState(() {
        lessonString = lesson;
      });

      speak(lessonString).then((_) {
        setState(() {
          isPlaying = false;
        });
      });
    }
  }

  @override
  void dispose() {
    stop();
    // flutterTts = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabet Lesson Player'),
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
                lessonString,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
