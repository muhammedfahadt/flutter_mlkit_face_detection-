import 'package:flutter/material.dart';
import 'package:traffic_patrol/src/localization/app_localizations.dart';

import 'package:traffic_patrol/src/pages/widgets/app_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
      title: 'Traffic Patrol',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AppHomePage(),
    );
  }
}  



