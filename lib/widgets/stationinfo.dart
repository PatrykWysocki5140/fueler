import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:fueler/pages/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        onPressed: () {},
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
