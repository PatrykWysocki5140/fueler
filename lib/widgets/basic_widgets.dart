import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:fueler/pages/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../layouts/main-layout.dart';

class LoginWidget extends StatelessWidget {
  final IconData icon;
  //final String text;
  const LoginWidget({required this.icon /*, required this.text*/});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: "loginbutton",
            backgroundColor: Colors.transparent,
            label: Text(
                AppLocalizations.of(context)!.buttonClicksDescriptionLogin),
            icon: Icon(icon),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainLayout(page: 2)));
            },
          ),
        ],
      ),
    );
  }
}

/*
class NavigationWidget extends StatelessWidget {
  final int page;
  final IconData icon;
  final AppLocalizations text;
  // ignore: use_key_in_widget_constructors
  const NavigationWidget(
      {required this.page, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            label: Text(AppLocalizations.of(context)!.text),
            icon: Icon(icon),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainLayout(page: page)));
            },
          ),
        ],
      ),
    );
  }
}
*/
class IconWidget extends StatelessWidget {
  final IconData icon;
  const IconWidget({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 50.0);
  }
}

/*
return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          FloatingActionButton.extended(
            label: Text('Przycisk'),
            onPressed: () {},
          ),
        ],
      ),
    );


    return Card(
      child: TextButton.icon(
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: Colors.blue),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () => {},
        icon: Icon(icon),
        label: Text(text),
      ),
    );
    */