import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _SettingsStat();
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
    return Consumer<LanguageNotifier>(builder: (context, languages, child) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.download,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.download,
                        onPressed: () {
                          /* Do something */
                        },
                        icon: const Icon(
                          Icons.download,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.favorites,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.favorites,
                        onPressed: () {
                          /* Do something */
                        },
                        icon: const Icon(
                          Icons.grade,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.payments,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.payments,
                        onPressed: () {
                          /* Do something */
                        },
                        icon: const Icon(
                          Icons.shopping_cart_checkout,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.login,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.login,
                        onPressed: () {
                          /* Do something */
                        },
                        icon: const Icon(
                          Icons.login,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.lang,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.lang,
                        onPressed: () {
                          if (languages.currentLanguage == "pl") {
                            languages.currentLanguage = "en";
                          } else {
                            languages.currentLanguage = "pl";
                          }
                        },
                        icon: const Icon(
                          Icons.abc,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.terminal,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.terminal,
                        onPressed: () {
                          /* Do something */
                        },
                        icon: const Icon(
                          Icons.terminal,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Consumer<NightMode>(
                            builder: (context, nightMode, child) =>
                                FutureBuilder(
                                    future: nightMode.enabled,
                                    initialData: false,
                                    builder: (BuildContext context,
                                            AsyncSnapshot<bool> snapshot) =>
                                        FloatingActionButton.extended(
                                          label: Text(
                                              snapshot.data ?? false
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .light
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .dark,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          tooltip: snapshot.data ?? false
                                              ? AppLocalizations.of(context)!
                                                  .light
                                              : AppLocalizations.of(context)!
                                                  .dark,
                                          onPressed: () =>
                                              nightMode.switchTheme(),
                                          icon: const Icon(
                                            Icons.toggle_off,
                                            size: 30,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        )))),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: FloatingActionButton.extended(
                        label: Text(AppLocalizations.of(context)!.sort,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        tooltip: AppLocalizations.of(context)!.sort,
                        onPressed: () {
                          /* Do something */
                        },
                        icon: const Icon(
                          Icons.sort,
                          size: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: FloatingActionButton(
                        tooltip: 'exit_to_app',
                        onPressed: () {
                          /* Do something */
                        },
                        child: const Icon(
                          Icons.exit_to_app,
                          size: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: FloatingActionButton(
                        tooltip: 'key',
                        onPressed: () {
                          /* Do something */
                        },
                        child: const Icon(
                          Icons.key,
                          size: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: FloatingActionButton(
                        tooltip: 'star',
                        onPressed: () {
                          /* Do something */
                        },
                        child: const Icon(
                          Icons.star,
                          size: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
