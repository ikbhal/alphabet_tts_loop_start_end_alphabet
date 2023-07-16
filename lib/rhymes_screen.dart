import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class RhymesScreen extends StatelessWidget {
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
          return ListTile(
            title: Text(rhyme),
            onTap: () {
              final rhymeAsset = rhymeAssets[index];
              playRhyme(rhymeAsset);
            },
          );
        },
      ),
    );
  }

  Future<void> playRhyme(String assetPath) async {
    await audioPlayer.play(AssetSource(assetPath));
  }
}
