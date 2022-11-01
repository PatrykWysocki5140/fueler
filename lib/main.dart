import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';

import 'package:fueler/layouts/main-layout.dart';
import 'package:fueler/widgets/language-switcher.dart';
import 'package:fueler/pages/settings_page.dart';
import 'package:provider/provider.dart';

import 'bloc pattern/bloc/bloc_main.dart';
import 'bloc pattern/style/styles.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LanguageNotifier()),
      ChangeNotifierProvider<NightMode>.value(value: NightMode()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<NightMode>(
      builder: (context, nightMode, child) => Consumer<LanguageNotifier>(
          builder: (context, languages, child) => FutureBuilder<ThemeData>(
              future: nightMode.getTheme(),
              initialData: Styles.themeData(false),
              builder: (BuildContext context,
                      AsyncSnapshot<ThemeData> themeData) =>
                  MaterialApp(
                      title: 'Fueler',
                      theme: themeData.data,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales:
                          languages.languages.entries.map((e) => Locale(e.key)),
                      locale: Locale(languages.language.key),
                      home: child ?? const SizedBox.shrink())),
          child: const MyHomePage(title: '')));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Root();
  }
}
