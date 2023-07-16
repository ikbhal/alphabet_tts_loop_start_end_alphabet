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
              // begin of english card
              SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/englishPlayer');
                              },
                              child: Text('English Player'),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/englishHelp');
                              },
                              child: Text('English Help'),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/daysOfWeek');
                              },
                              child: Text('Days of Week'),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/monthsOfYear');
                              },
                              child: Text('Months of Year'),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/rhymes');
                              },
                              child: Text('Rhymes'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // )

              // endof english
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
