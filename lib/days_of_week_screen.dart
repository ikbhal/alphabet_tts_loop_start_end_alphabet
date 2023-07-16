import 'package:flutter/material.dart';
import 'day_screen.dart';

class DaysOfWeekScreen extends StatelessWidget {
  final List<String> daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Days of the Week'),
      ),
      body: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          final day = daysOfWeek[index];
          return Container(
            height: MediaQuery.of(context).size.height / 7, // Divide the screen height equally among the days
            child: ListTile(
              title: Center(child: Text(day.toUpperCase())),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DayScreen(day: day),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
