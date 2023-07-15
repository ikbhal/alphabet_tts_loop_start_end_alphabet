import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'english_player.dart';
import 'number_player.dart';
import 'hindi_player.dart';
import 'kannada_player.dart';
import 'english_help_screen.dart';
import 'number_help_screen.dart';
import 'hindi_help_screen.dart';
import 'kannada_help_screen.dart';

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
        '/englishHelp': (context) => EnglishHelpScreen(),
        '/numberHelp': (context) => NumberHelpScreen(),
        '/hindiHelp': (context) => HindiHelpScreen(),
        '/kannadaHelp': (context) => KannadaHelpScreen(),
      },
    );
  }
}
