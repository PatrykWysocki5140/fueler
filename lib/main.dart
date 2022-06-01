import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:fueler/settings/themes/styles.dart';
import 'package:fueler/widgets/language-switcher.dart';
import 'package:fueler/widgets/theme_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LanguageNotifier()),
      ChangeNotifierProvider<NightMode>.value(value: NightMode())
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
                      title: 'test apki',
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
          child: const MyHomePage(title: 'Flutter Demo Home Page')));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: LanguageSwitcher(),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.buttonClicksDescription),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ////
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.plus_one),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        },
        tooltip: 'Settings',
        child: const Icon(Icons.settings),
      ),
    );
  }
}
