import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/lib/utils/theme_manager.dart';
import 'package:app/lib/utils/locale_manager.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final localeManager = Provider.of<LocaleManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeManager.isDarkMode,
            onChanged: (bool value) {
              themeManager.toggleTheme();
            },
          ),
          ListTile(
            title: Text('Change Language'),
            onTap: () {
              // Open language selection
              // For demonstration, let's say we toggle between English and Spanish
              localeManager.setLocale(Locale('es'));
            },
          ),
          // Add more settings options as needed
        ],
      ),
    );
  }
}