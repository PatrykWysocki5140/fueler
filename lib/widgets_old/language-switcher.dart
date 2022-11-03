import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/notifiers/LanguageNotifier.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
