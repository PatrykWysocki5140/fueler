import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/MapNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:fueler/routes/navigation.dart';
import 'package:fueler/routes/routes.dart';
import 'package:fueler/style/styles.dart';
import 'package:provider/provider.dart';
import 'notifiers/APINotifier.dart';
import 'notifiers/auth.dart';
import 'dart:developer';
import 'routes/UI/splash_screen/splash_screen_page.dart';

//late final BuildContext Parentcontext;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log("start");
  final AuthModel _auth = AuthModel();
  final Api api = Api();
  //api.GetLocalUser();
  //log("id:" + api.user.id.toString());
  //_auth.loadSettings();
  /*
  try {
  } catch (e) {
    log("Error Loading User Settings: $e");
  }*/
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LanguageNotifier()),
      ChangeNotifierProvider<NightMode>.value(value: NightMode()),
      ChangeNotifierProvider<AuthModel>.value(value: _auth),
      ChangeNotifierProvider<Api>(create: (context) => api),
      ChangeNotifierProvider<GoogleMaps>(create: (context) => GoogleMaps())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) => Consumer<Api>(
      builder: (context, apimodel, child) => Consumer<GoogleMaps>(
          builder: (context, maps, child) => Consumer<AuthModel>(
              builder: (context, model, child) => Consumer<NightMode>(
                  builder: (context, nightMode, child) =>
                      Consumer<LanguageNotifier>(
                        builder: (context, languages, child) =>
                            FutureBuilder<ThemeData>(
                                future: nightMode.getTheme(),
                                initialData: Styles.themeData(false),
                                builder: (BuildContext context,
                                    AsyncSnapshot<ThemeData> themeData) {
                                  //const SplashScreen("/main");
                                  //Parentcontext = context;
                                  //setContext(context);
                                  Provider.of<Api>(context).GetLocalUser();

                                  return MaterialApp(
                                    title: 'Fueler',
                                    onGenerateRoute: routes,
                                    theme: themeData.data,
                                    localizationsDelegates: const [
                                      AppLocalizations.delegate,
                                      GlobalMaterialLocalizations.delegate,
                                      GlobalWidgetsLocalizations.delegate,
                                      GlobalCupertinoLocalizations.delegate,
                                    ],
                                    supportedLocales: languages
                                        .languages.entries
                                        .map((e) => Locale(e.key)),
                                    locale: Locale(languages.language.key),
                                    initialRoute: '/',
                                    //home: child ?? const SizedBox.shrink()
                                    home:
                                        /*
                          Consumer<AuthModel>(builder: (context, model, child) {
                        if (model.user != null) return SplashScreen("/main");
                        return SplashScreen("/main");
                      })*/
                                        const SplashScreen("/main"),
                                  );
                                }),
                        //child: const MyHomePage(title: '')
                      )))));
}

/*
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
*/
Route<dynamic> routes(RouteSettings settings) {
  log("routes" + settings.name.toString());
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const MainPageMenu(routesBuilder: subRoutes),
        // builder: (_) { const MainPageMenu(routesBuilder: subRoutes);},
      );
    case '/main':
      return MaterialPageRoute(
        builder: (_) => const MainPageMenu(routesBuilder: subRoutes),
        // builder: (_) { const MainPageMenu(routesBuilder: subRoutes);},
      );
    case '/parent':
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('Parent'),
          ),
        ),
      );
    default:
      throw 'unexpected Route';
  }
}
