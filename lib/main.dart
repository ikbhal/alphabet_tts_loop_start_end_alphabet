import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'english_player.dart';
import 'number_player.dart';
import 'hindi_player.dart';
import 'kannada_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/englishPlayer': (context) => EnglishPlayer(),
        '/numberPlayer': (context) => NumberPlayer(),
        '/hindiPlayer': (context) => HindiPlayer(),
        '/kannadaPlayer': (context) => KannadaPlayer(),
      },
    );
  }
}
