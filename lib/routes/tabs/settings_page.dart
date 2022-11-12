import 'package:bart/bart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:fueler/notifiers/ThemeNotifier.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';

import '../../settings/Get_size.dart';

class SettingsPage extends StatelessWidget with AppBarNotifier {
  final BuildContext parentContext;
  const SettingsPage({
    Key? key,
    required this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageNotifier>(
      builder: (context, languages, child) {
        return Scaffold(
            body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.settings,
                  style: TextStyle(
                      fontSize: GetSize.fontSizeH1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //Center Row contents horizontally,
                children: [
                  Container(
                    width: GetSize.floatingActionButtonWidth,
                    child: FloatingActionButton.extended(
                      label: Text(
                        AppLocalizations.of(context)!.lang,
                      ),
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: GetSize.floatingActionButtonWidth,
                      child: Consumer<NightMode>(
                          builder: (context, nightMode, child) => FutureBuilder(
                              future: nightMode.enabled,
                              initialData: false,
                              builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) =>
                                  FloatingActionButton.extended(
                                    label: Text(
                                        snapshot.data ?? false
                                            ? AppLocalizations.of(context)!
                                                .light
                                            : AppLocalizations.of(context)!
                                                .dark,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    tooltip: snapshot.data ?? false
                                        ? AppLocalizations.of(context)!.light
                                        : AppLocalizations.of(context)!.dark,
                                    onPressed: () => nightMode.switchTheme(),
                                    icon: const Icon(
                                      Icons.toggle_off,
                                      size: 30,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ))))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: GetSize.floatingActionButtonWidth,
                    child: FloatingActionButton.extended(
                      label: Text(AppLocalizations.of(context)!.exit,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      tooltip: AppLocalizations.of(context)!.exit,
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        size: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
      },
    );
  }
}
