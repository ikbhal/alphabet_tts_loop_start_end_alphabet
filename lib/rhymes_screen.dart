import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RhymesScreen extends StatefulWidget {
  @override
  _RhymesScreenState createState() => _RhymesScreenState();
}

class _RhymesScreenState extends State<RhymesScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<String> rhymes = [
    'Twinkle, Twinkle, Little Star',
    'Row, Row, Row Your Boat',
    'Humpty Dumpty sat on a wall',
    'Baa, baa, black sheep',
  ];

  final List<String> rhymeAssets = [
    'english/rhymes/twinkle_twinkel_star.mp4',
    'english/rhymes/row_row.mp4',
    'english/rhymes/Humpty_Dumpty.mp4',
    'english/rhymes/Baa,_Baa,_Black_Sheep.mp4'
  ];

  final FlutterTts flutterTts = FlutterTts();
  final Random random = Random();
  bool isPlaying = false;

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rhymes List'),
      ),
      body: ListView.builder(
        itemCount: rhymes.length,
        itemBuilder: (context, index) {
          final rhyme = rhymes[index];
          return Container(
            // height: MediaQuery.of(context).size.height / rhymes.length,
            child: ListTile(
              title: Center(
                child: Text(
                  rhyme,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: Colors
                    //     .primaries[random.nextInt(Colors.primaries.length)],
                  ),
                ),
              ),
              onTap: () {
                final rhymeAsset = rhymeAssets[index];
                if (isPlaying) {
                  audioPlayer.stop();
                }
                playRhyme(rhymeAsset);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> playRhyme(String assetPath) async {
    setState(() {
      isPlaying = true;
    });
    await audioPlayer.play(AssetSource(assetPath));
    // audioPlayer.onPlayerComplete
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }
}
