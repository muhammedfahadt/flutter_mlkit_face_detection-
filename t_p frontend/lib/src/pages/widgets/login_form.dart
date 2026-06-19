import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:traffic_patrol/src/localization/app_localizations.dart';

import 'app_home_page.dart';
import 'managed_user_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});  

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Openapi _openapi = Openapi();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.loginFailed),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showError(AppLocalizations.of(context)!.usernamePasswordRequired);
      return;
    }

    try {
      final loginBuilder = LoginVMBuilder()
        ..username = username
        ..password = password;

      final result = await _openapi.getAuthenticateControllerApi().authorize(
        loginVM: loginBuilder.build(),
      );

      debugPrint('Authenticated status: ${result.statusCode}');
      debugPrint(
        'Successful login: ${result.statusCode == 200 && result.data?.idToken != null}',
      );
      debugPrint('Token: ${result.data?.idToken}');

      // 401 for invalid credentials, anything else success depends on API contract.
      if (result.statusCode != 401 && result.data?.idToken != null) {
        Openapi.bearerToken = result.data!.idToken!;

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppHomePage()),
        );
      } else {
        _showError(AppLocalizations.of(context)!.invalidCredentials);
      }
    } catch (e, st) {
      debugPrint('Login error: $e');
      debugPrintStack(stackTrace: st);
      _showError(AppLocalizations.of(context)!.invalidCredentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: l10n.username),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: l10n.password),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text(l10n.login),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      l10n.dontHaveAccountSignUp,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
