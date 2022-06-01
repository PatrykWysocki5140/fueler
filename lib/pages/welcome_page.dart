import 'package:flutter/material.dart';
import 'package:fueler/layouts/main-layout.dart';
import 'package:fueler/widgets/basic_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/widgets/stationinfo.dart';
import '../widgets/log-in.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 10),
          const Login(),
          Center(
            //widthFactor: 100,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              //mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                FloatingActionButton.extended(
                  label: Text(
                      AppLocalizations.of(context)!.buttonClicksSearchStation),
                  icon: const Icon(Icons.near_me),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainLayout(page: 1)));
                  },
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(AppLocalizations.of(context)!.populartoday),
                      ],
                    ),
                    Row(
                      children: const [
                        StationInfo(
                          stationicon: Icons.login,
                          stationaddress: "Poznań, ulica: xyz 123A",
                          pb: 314.1,
                          on: 314,
                          lpg: 314,
                        ),
                      ],
                    ),
                  ],
                )
                ///// tu wjedzie widget customowy const StationInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Login(),
            ],
          ),
        ),
      )
    );
    */
    /*return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Login(),
      ),
    );*/
