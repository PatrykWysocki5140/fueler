import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/layouts/main-layout.dart';
import 'package:fueler/widgets/stationinfo.dart';

import '../widgets/log-in.dart';

/*
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {*/
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key); //nie było

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const Login(),
          Center(
            child: Column(
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
                            builder: (context) => MainLayout(page: 4)));
                  },
                ),
                Container(
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(AppLocalizations.of(context)!.populartoday),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            StationInfo(
                              stationicon: Icons.login,
                              stationaddress: "Poznań, ulica: xyz 123A",
                              pb: 314.1,
                              on: 314,
                              lpg: 314,
                              grade: 1,
                            ),
                          ],
                        )
                      ],
                    )),
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
