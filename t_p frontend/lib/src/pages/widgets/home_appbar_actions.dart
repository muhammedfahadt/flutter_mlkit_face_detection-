import 'package:flutter/material.dart';
import 'package:traffic_patrol/src/localization/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Theme switch (light / dark)
        PopupMenuButton<ThemeMode>(
          tooltip: loc.theme,
          initialValue: _themeMode,
          icon: const Icon(Icons.dark_mode_outlined),
          itemBuilder: (context) => [
            PopupMenuItem(value: ThemeMode.light, child: Text(loc.light)),
            PopupMenuItem(value: ThemeMode.dark, child: Text(loc.dark)),
            PopupMenuItem(value: ThemeMode.system, child: Text(loc.system)),
          ],
          onSelected: (mode) {
            setState(() => _themeMode = mode);
            widget.onThemeChanged(mode);
          },
        ),

        const SizedBox(width: 8),

        // Language switch (UI language)
        PopupMenuButton<Locale>(
          tooltip: loc.language,
          icon: const Icon(Icons.language_outlined),
          itemBuilder: (context) => [
            PopupMenuItem(value: const Locale('en', ''), child: Text(loc.english)),
            PopupMenuItem(value: const Locale('ml', ''), child: Text(loc.malayalam)),
            PopupMenuItem(value: const Locale('hi', ''), child: Text(loc.hindi)),
          ],
          onSelected: (loc) {
            widget.onLocaleChanged(loc);
          },
        ),
      ],
    );
  }
}
