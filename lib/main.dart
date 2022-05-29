import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:fueler/layouts/main-layout.dart';
import 'package:fueler/widgets/language-switcher.dart';
import 'package:fueler/widgets/theme_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LanguageNotifier()),
      ChangeNotifierProvider<NightMode>.value(value: NightMode())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NightMode usertheme = Provider.of<NightMode>(context);
    return Consumer<LanguageNotifier>(
        builder: (context, languages, child) => MaterialApp(
            title: 'test apki',
            theme: usertheme.getTheme(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:
                languages.languages.entries.map((e) => Locale(e.key)),
            locale: Locale(languages.language.key),
            home: child ?? const SizedBox.shrink()),
        child: const MyHomePage(title: ''));
  }
}
///////////////////////////////////////////////////////////////////////////

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(),
    );
  }
}

/*
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
              onPressed: // _incrementCounter
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
              tooltip: 'Increment',
              child: const Icon(Icons.plus_one),
            )

            ///
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
*/