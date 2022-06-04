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
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(GetColors.green), maximumSize: const Size(200, 200).
          
        ),
        child: Container(        
          child: Column( children: <Widget>[
            Row(
              children: <Widget>[Text(stationaddress)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Column(
                children: [
                  const Image(image: AssetImage('pb95.png'), width: 20, height: 20),
                  const Text('7,30'),
                ],
              ),
              Column(
                children: [
                  const Image(image: AssetImage('on.png'), width: 20, height: 20),
                  const Text('6,2'),
                ],
              ),
              Column(
                children: [
                  const Image(image: AssetImage('lpg.png'), width: 20, height: 20),
                  const Text('2,21'),
                ],
              ),
              Column(
                
                children: [
                  const Image(image: AssetImage('orlen_logo.png'), width: 40, height: 40),
                  ],
              ),
            ])
          ],
        )));
  }
}