import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class NumberPlayer extends StatefulWidget {
  @override
  _NumberPlayerState createState() => _NumberPlayerState();
}

class _NumberPlayerState extends State<NumberPlayer> {
  final TextEditingController startNumberController =
  TextEditingController(text:'0');
  final TextEditingController endNumberController =
  TextEditingController(text:'50');
  final TextEditingController repeatCountController =
  TextEditingController(text: '1');
  FlutterTts flutterTts = FlutterTts();
  int currentNumber = 0;
  bool isPlaying = false;

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
    if (mounted && isPlaying) {
      await flutterTts.stop();
      setState(() {
        isPlaying = false;
      });
    }
  }


  Future<bool> playNumber(int number) async {
    // Set the current number
    setState(() {
      currentNumber = number;
    });

    // Speak the current number
    await speak(number.toString());

    return true;
  }

  void playNumberSequence() async {
    final int startNumber = int.parse(startNumberController.text);
    final int endNumber = int.parse(endNumberController.text);
    final int repeatCount = int.parse(repeatCountController.text);

    if (startNumber <= endNumber && repeatCount > 0) {
      setState(() {
        isPlaying = true;
      });

      // final random = Random();

      for (int i = 0; i < repeatCount && isPlaying; i++) {
        for (int j = startNumber; mounted && isPlaying && j <= endNumber; j++) {
          await playNumber(j);
          await Future.delayed(Duration(milliseconds: 2000)); // Delay for 2 seconds
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
        title: Text('Number Player'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: startNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Start Number',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: endNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'End Number',
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
                    onPressed: isPlaying ? null : playNumberSequence,
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
                currentNumber.toString(),
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
