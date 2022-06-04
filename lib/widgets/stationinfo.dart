import 'package:flutter/material.dart';

import '../layouts/main-layout.dart';

class StationInfo extends StatelessWidget {
  final IconData stationicon;
  final String stationaddress;
  final double pb;
  final double on;
  final double lpg;
  final int grade;

  const StationInfo({
    required this.stationicon,
    required this.stationaddress,
    required this.pb,
    required this.on,
    required this.lpg,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainLayout(page: 5))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text(stationaddress)],
            ),
            Row(
                ////children: ], no i tutja dalej
                )
          ],
        ));
  }
}
