import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traffic_patrol/src/pages/widgets/config.dart';
import 'package:traffic_patrol/src/pages/widgets/upload_widget.dart';
import 'package:openapi/openapi.dart';

class ManagedUser {
  final String id;
  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  ManagedUser(
    this.id,
    this.login,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  );

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}

class AppUser {
  final String phoneNumber;
  final String address;
  final String pinCode;
  final ManagedUser user;

  AppUser({
    required this.phoneNumber,
    required this.address,
    required this.pinCode,
    required this.user,
  });
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  Openapi _openapi = Openapi();
  Future<void> _signUp(BuildContext context) async {
    try {
      ManagedUserVMBuilder managedUserVMBuilder = ManagedUserVMBuilder()
        ..login = _loginController.text
        ..firstName = _firstNameController.text
        ..lastName = _lastNameController.text
        ..email = _emailController.text
        ..password = _passwordController.text
        ..activated = true;

      ManagedUserVM managedUserVM = managedUserVMBuilder.build();
      final userResponse = await _openapi
          .getAccountResourceApi()
          .registerAccount(managedUserVM: managedUserVM);
      debugPrint('#############################user');
      debugPrint('${userResponse.statusCode}');
      if (userResponse.statusCode == 201) {
        // User registered successfully
        //     final Map<String, dynamic> responseData = jsonDecode(userRespons);
        LoginVMBuilder loginVMBuilder = LoginVMBuilder()
          ..username = _loginController.text
          ..password = _passwordController.text
          ..rememberMe = true;

        LoginVM loginVM = loginVMBuilder.build();
        final jwtResponse = await _openapi
            .getAuthenticateControllerApi()
            .authorize(loginVM: loginVM);
        debugPrint('#############################jwt');
        debugPrint('${jwtResponse.statusCode}');
        if (jwtResponse.statusCode == 200 || jwtResponse.statusCode == 201) {
          Configuration.secureStorage.write(
            key: 'jwt',
            value: jwtResponse.data?.idToken,
          );
          String? jwt = jwtResponse.data?.idToken;
          // After login (jwtResponse success)
          // 1. Fetch current user info first
          final currentUser = await _openapi.getAccountResourceApi().getAccount(
            headers: {'Authorization': 'Bearer $jwt'},
          );

          // 2. Now build the UserDTO using the data from the server
          UserDTOBuilder userDTOBuilder = UserDTOBuilder()
            ..id = currentUser.data?.id
            ..login = currentUser.data?.login;
          // Create AppUserDTO with user data

          AppUserDTOBuilder appUserDTOBuilder = AppUserDTOBuilder()
            ..phoneNumber = int.tryParse(_phoneNumberController.text)
            ..address = _addressController.text
            ..pinCode = int.tryParse(_pinCodeController.text)
            ..user = userDTOBuilder;
          AppUserDTO appUserDTO = appUserDTOBuilder.build();
          // Make a POST request to register the AppUser

          print('Authorization token: $jwt');
          final appUserResponse = await _openapi
              .getAppUserResourceApi()
              .createAppUser(
                appUserDTO: appUserDTO,
                headers: {'Authorization': 'Bearer $jwt'},
              );
          debugPrint('AppUser Status: ${appUserResponse.statusCode}');
          debugPrint(
            'AppUser Body: ${appUserResponse.data.toString()}',
          ); // Add this!
          if (appUserResponse.statusCode == 201) {
            Configuration.secureStorage.write(
              key: 'appuserId',
              value: appUserResponse.data?.id.toString(),
            );
            Configuration.secureStorage.write(
              key: 'appUsernumber',
              value: appUserResponse.data?.phoneNumber.toString(),
            );
            // AppUser registered successfully
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Registration'),
                content: Text('User registered'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CameraApp()),
                    ),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            // Error occurred during AppUser registration
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Registration'),
                content: Text('Registration Failed'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      } else {
        // Error occurred during user registration
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration'),
            content: Text('Try once more'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        print('Error occurred during user registration');
      }
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration'),
          content: Text('Registration Failed'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Add MaterialApp or WidgetsApp here
      home: Scaffold(
        appBar: AppBar(title: Text('Sign Up')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'Firstname'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Lastname'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText:
                      true, // Set obscureText to true for password fields
                ),
              TextField(
  controller: _phoneNumberController,
  keyboardType: TextInputType.number,
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly // Ensures only digits can be typed
  ],
  decoration: InputDecoration(labelText: 'Phone Number'),
),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: _pinCodeController,
                  decoration: InputDecoration(labelText: 'Pin Code'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _signUp(context),
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
