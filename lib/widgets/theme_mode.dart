//setting który mozna przerabiać

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // ignore: prefer_typing_uninitialized_variables
  var checked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //title: Text(AppLocalizations.of(context)!.buttonClicksDescription),
        title: const Text("dupa"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              settingsWidget("Dark mode", FontAwesomeIcons.moon, context)
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsWidget(name, icon, context) {
    NightMode usertheme = Provider.of<NightMode>(context);
    checked = usertheme.getEnabled();

    return ListTile(
        title: Text(name),
        subtitle: const Text("Turn dark mode on / off"),
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        onTap: () {
          setState(() {
            checked = !checked;
            if (checked) {
              usertheme.userthemeMode = ThemeData.dark();
            } else {
              usertheme.userthemeMode = ThemeData.light();
            }
            usertheme.enabled = checked;
          });
        },
        trailing: Checkbox(
          onChanged: (value) {
            setState(() {
              checked = value;

              if (checked) {
                usertheme.userthemeMode = ThemeData.dark();
              } else {
                usertheme.userthemeMode = ThemeData.light();
              }
              usertheme.enabled = checked;
            });
          },
          value: checked,
        ));
  }
}
