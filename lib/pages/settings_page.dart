import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:fueler/widgets/language-switcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checked;
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Settings',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Colors.grey)),
      home: const _SettingsStat(),
    );
  }
}

class _SettingsStat extends StatefulWidget {
  const _SettingsStat({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_SettingsStat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Pobrane  ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Download',
                    onPressed: () {/* Do something */},
                    icon: const Icon(
                      Icons.download,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Ulubione ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Grade',
                    onPressed: () {/* Do something */},
                    icon: const Icon(
                      Icons.grade,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Płatności",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Payment',
                    onPressed: () {/* Do something */},
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Logowanie",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Log in',
                    onPressed: () {/* Do something */},
                    icon: const Icon(
                      Icons.login,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Język    ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Language',
                    onPressed: () {},
                    icon: const Icon(
                      Icons.abc,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Terminal ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Terminal',
                    onPressed: () {/* Do something */},
                    icon: const Icon(
                      Icons.terminal,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: settingsWidget(
                        "Dark mode", FontAwesomeIcons.moon, context)),
                SizedBox(
                  width: 22,
                ),
                Center(
                  child: FloatingActionButton.extended(
                    label: const Text("Sort     ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 30, 30),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    tooltip: 'Sort',
                    onPressed: () {/* Do something */},
                    icon: const Icon(
                      Icons.sort,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: FloatingActionButton(
                    tooltip: 'exit_to_app',
                    onPressed: () {/* Do something */},
                    child: const Icon(
                      Icons.exit_to_app,
                      size: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: FloatingActionButton(
                    tooltip: 'key',
                    onPressed: () {/* Do something */},
                    child: const Icon(
                      Icons.key,
                      size: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: FloatingActionButton(
                    tooltip: 'star',
                    onPressed: () {/* Do something */},
                    child: const Icon(
                      Icons.star,
                      size: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsWidget(name, icon, context) {
    return Consumer<NightMode>(
        builder: (context, nightMode, child) => FutureBuilder(
            future: nightMode.enabled,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                FloatingActionButton.extended(
                  label: const Text("Dark    ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 31, 30, 30),
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  tooltip: 'Dark',
                  onPressed: () => nightMode.switchTheme(),
                  icon: const Icon(
                    Icons.toggle_off,
                    size: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                )));
  }

  Widget languageWidget() {
    return Consumer<LanguageNotifier>(builder: (context, languages, child) {
      return DropdownButton(
        items: languages.languages.entries
            .map<DropdownMenuItem<String>>((MapEntry<String, String> entry) =>
                DropdownMenuItem(child: Text(entry.value), value: entry.key))
            .toList(),
        onChanged: (String? newValue) {
          languages.currentLanguage = newValue!;
        },
        value: AppLocalizations.of(context)!.localeName,
      );
    });
  }
}
