import 'package:flutter/material.dart';
import 'package:traffic_patrol/src/localization/app_localizations.dart';

import 'package:traffic_patrol/src/pages/widgets/app_home_page.dart';
import 'package:traffic_patrol/src/pages/widgets/login_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');
  ThemeMode _themeMode = ThemeMode.system;

  void _changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  void _changeTheme(ThemeMode newTheme) {
    setState(() {
      _themeMode = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _themeMode,
      title: 'Traffic Patrol',
      home: LoginForm(
        onLocaleChanged: _changeLocale,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}  



