import 'package:flutter/material.dart';
import 'package:fueler/settings/themes/styles.dart';

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
        child: Container(
            child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text(stationaddress)],
            ),
            Row(children: [
              Column(
                children: [
                  Text(
                    pb.toStringAsFixed(2),
                    style: TextStyle(color: GetColors.orange),
                  )
                  //zdjecie
                  //cena
                ],
              ),
              Column(
                children: [
                  //Text(pb.toString())
                  //zdjecie
                  //cena
                ],
              ),
              Column(
                children: [
                  //Text(pb.toString())
                  //zdjecie
                  //cena
                ],
              ),
              Column(
                children: [
                  //zdjecie logo stacji
                ],
              ),
            ])
          ],
        )));
  }
}
