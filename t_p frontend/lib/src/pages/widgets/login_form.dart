import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

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
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showError('Username and password are required.');
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
        // Avoid referencing CameraApp here unless it's guaranteed to be available.
        // If your app has a home screen widget, swap this to Navigator.pushReplacement.
        Text('Login successful! Token: ${result.data!.idToken}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppHomePage()),
        );
      } else {
        _showError('Invalid username or password.');
      }
    } catch (e, st) {
      debugPrint('Login error: $e');
      debugPrintStack(stackTrace: st);
      _showError('Invalid username or password.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
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
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.blue),
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
