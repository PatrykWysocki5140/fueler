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
          backgroundColor: MaterialStateProperty.all(GetColors.green)),
        child: Container(        
          child: Column( children: <Widget>[
            Row(
              children: <Widget>[Text(stationaddress)],
            ),
            Container(padding: EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Container(padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                children: [
                  const Image(image: AssetImage('pb95.png'), width: 30, height: 30),
                  Text(pb.toStringAsFixed(2)),
                ],
              ),
              ),
              Container(padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const Image(image: AssetImage('on.png'), width: 30, height: 30),
                  Text(on.toStringAsFixed(2)),
                ],
              ),
              ),
              Container(padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const Image(image: AssetImage('lpg.png'), width: 30, height: 30),
                  Text(lpg.toStringAsFixed(2)),
                ],
              ),
              ),
              Container(padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
              children: [
                  const Image(image: AssetImage('orlen_logo.png'), width: 60, height: 60),
              ],
              ),
              ),
            ]))
          ],
        )));
  }
}