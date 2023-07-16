import 'package:flutter/material.dart';

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
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/englishPlayer');
                        },
                        title: Text('English'),
                        leading: IconButton(
                          icon: Icon(Icons.play_arrow),
                          onPressed: () {
                            Navigator.pushNamed(context, '/englishPlayer');
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.help),
                          onPressed: () {
                            Navigator.pushNamed(context, '/englishHelp');
                          },
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/daysOfWeek');
                        },
                        title: Text('Days of Week'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/numberPlayer');
                    },
                    title: Text('Numbers'),
                    leading: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        Navigator.pushNamed(context, '/numberPlayer');
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.help),
                      onPressed: () {
                        Navigator.pushNamed(context, '/numberHelp');
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/hindiPlayer');
                    },
                    title: Text('Hindi'),
                    leading: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        Navigator.pushNamed(context, '/hindiPlayer');
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.help),
                      onPressed: () {
                        Navigator.pushNamed(context, '/hindiHelp');
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/kannadaPlayer');
                    },
                    title: Text('Kannada'),
                    leading: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        Navigator.pushNamed(context, '/kannadaPlayer');
                      },
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.help),
                      onPressed: () {
                        Navigator.pushNamed(context, '/kannadaHelp');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
