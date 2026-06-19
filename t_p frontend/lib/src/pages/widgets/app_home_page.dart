import 'package:flutter/material.dart';

import 'package:traffic_patrol/src/localization/app_localizations.dart';
import 'package:traffic_patrol/src/pages/widgets/home_appbar_actions.dart';
import 'package:traffic_patrol/src/pages/widgets/login_form.dart';
import 'package:traffic_patrol/src/pages/widgets/upload_widget.dart';

/// Post-login landing page.
///
/// Routes to feature pages instead of navigating directly from login/signup.
class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  // UI-only state (app theme/language are handled elsewhere in this project).
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en', '');

  @override
  Widget build(BuildContext context) {

    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations?.appTitle ?? 'Traffic Patrol'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: HomeAppBarActions(
              onThemeChanged: (mode) {
                setState(() => _themeMode = mode);
              },
              onLocaleChanged: (locale) {
                setState(() => _locale = locale);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations?.home ?? 'Home',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _HomeActionCard(
                    icon: Icons.upload_file_outlined,
                    title: localizations?.upload ?? 'Upload',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CameraApp()),
                      );
                    },
                  ),
                  _HomeActionCard(
                    icon: Icons.login_outlined,
                    title: localizations?.login ?? 'Login',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginForm()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 


class _HomeActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HomeActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 28),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
