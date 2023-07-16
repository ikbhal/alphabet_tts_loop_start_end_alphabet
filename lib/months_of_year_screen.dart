import 'package:flutter/material.dart';
import 'month_screen.dart';

class MonthsOfYearScreen extends StatelessWidget {
  final List<String> monthsOfYear = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Months of the Year'),
      ),
      body: ListView.builder(
        itemCount: monthsOfYear.length,
        itemBuilder: (context, index) {
          final month = monthsOfYear[index];
          return Container(
              height: MediaQuery.of(context).size.height / 12,
              child: ListTile(
                title: Center(child: Text(month.toUpperCase())),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MonthScreen(month: month),
                    ),
                  );
                },
              ));
        },
      ),
    );
  }
}
