import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/englishAlphabetPlayer');
                  },
                  title: Text('English'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/numberPlayer');
                  },
                  title: Text('Numbers'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/hindiPlayer');
                  },
                  title: Text('Hindi'),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/kannadaPlayer');
                  },
                  title: Text('Kannada'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
