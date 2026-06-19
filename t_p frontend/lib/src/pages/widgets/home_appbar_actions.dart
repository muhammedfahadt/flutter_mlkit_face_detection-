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
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<HomeAppBarActions> createState() => _HomeAppBarActionsState();
}

class _HomeAppBarActionsState extends State<HomeAppBarActions> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en', '');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Theme switch (light / dark)
        PopupMenuButton<ThemeMode>(
          tooltip: 'Theme',
          initialValue: _themeMode,
          icon: const Icon(Icons.dark_mode_outlined),
          itemBuilder: (context) => const [
            PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
            PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            PopupMenuItem(value: ThemeMode.system, child: Text('System')),
          ],
          onSelected: (mode) {
            setState(() => _themeMode = mode);
            widget.onThemeChanged(mode);
          },
        ),

        const SizedBox(width: 8),

        // Language switch (UI language)
        PopupMenuButton<Locale>(
          tooltip: 'Language',
          initialValue: _locale,
          icon: const Icon(Icons.language_outlined),
          itemBuilder: (context) => const [
            PopupMenuItem(value: Locale('en', ''), child: Text('English')),
            // Add more languages here if you have arb/localization files.
            // Example:
            // PopupMenuItem(
            //   value: Locale('ta', ''),
            //   child: Text('தமிழ்'),
            // ),
          ],
          onSelected: (loc) {
            setState(() => _locale = loc);
            widget.onLocaleChanged(loc);
          },
        ),
      ],
    );
  }
}
