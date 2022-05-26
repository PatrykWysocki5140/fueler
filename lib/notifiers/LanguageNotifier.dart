import 'package:flutter/foundation.dart';

class LanguageNotifier extends ChangeNotifier {
  final Map<String, String> _supportedLanguages = const {
    "pl": "Polski",
    "en": "English"
  };

  MapEntry<String, String> _currentLanguage = const MapEntry("pl", "Polski");

  MapEntry<String, String> get language => _currentLanguage;

  set currentLanguage(String code) {
    _currentLanguage = _supportedLanguages.entries
        .firstWhere((element) => element.key == code, orElse: () => language);
    notifyListeners();
  }

  Map<String, String> get languages => _supportedLanguages;
}
