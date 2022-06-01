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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              settingsWidget("Dark mode", FontAwesomeIcons.moon, context)
            ],
          ),
        ),
      ),
    );
  }

/*
  Widget settingsWidget(name, icon, context) {
    return Consumer<NightMode>(
        builder: (context, nightMode, child) => FutureBuilder(
            future: nightMode.enabled,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                ListTile(
                    title: Text(name),
                    subtitle: const Text("Turn dark mode on / off"),
                    leading: Icon(
                      icon,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      nightMode.switchTheme();
                    },
                    trailing: Checkbox(
                      onChanged: (value) {
                        nightMode.switchTheme();
                      },
                      value: snapshot.data,
                    ))));
  }
}*/

  Widget settingsWidget(name, icon, context) {
    return Consumer<NightMode>(
        builder: (context, nightMode, child) => FutureBuilder(
            future: nightMode.enabled,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                FloatingActionButton.extended(
                    label: Text('Color change'),
                    tooltip: 'Color change',
                    onPressed: () => nightMode.switchTheme())));
  }
}
