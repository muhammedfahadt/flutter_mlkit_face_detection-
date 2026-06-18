import 'package:flutter/material.dart';

class HomeAppBarActions extends StatefulWidget {
  const HomeAppBarActions({
    super.key,
    required this.onThemeChanged,
    required this.onLocaleChanged,
  });

  /// Called when user selects Dark/Light theme.
  final ValueChanged<ThemeMode> onThemeChanged;

  /// Called when user selects a language.
