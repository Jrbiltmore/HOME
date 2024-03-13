import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'fr', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Simulated loading of language-specific data
    Map<String, String> localizedStrings = {
      "title": locale.languageCode == "en" ? "Welcome" : "Bienvenido",
      // Add more key-value pairs for other strings
    };

    return AppLocalizations(locale, localizedStrings);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}