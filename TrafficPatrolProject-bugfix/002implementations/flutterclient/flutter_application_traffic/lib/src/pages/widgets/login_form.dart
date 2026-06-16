import 'package:flutter/material.dart';
import 'package:flutter_application_traffic/src/pages/widgets/config.dart';
import 'package:flutter_application_traffic/src/pages/widgets/upload_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:openapi/openapi.dart';

import 'managed_user_widget.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Openapi _openapi = Openapi();
  @override
  Widget build(BuildContext context) {
return  
 Scaffold(
     body: Center(
      child: Container(
        width: 400,
          height: 400,
          child: Card(
           margin: EdgeInsets.all(16.0),
           child: Padding(padding:EdgeInsets.all(16.0),
           child: 

     Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true, // Hide password
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async  {
              // Check username and password (dummy validation)
             try{
              LoginVMBuilder loginVMBuilder = LoginVMBuilder()
                                            ..username = _usernameController.text
                                            ..password =_passwordController.text;

              LoginVM loginVM = loginVMBuilder.build();
              final rseponse =  await _openapi.getAuthenticateControllerApi().authorize(loginVM: loginVM);
              if (rseponse.statusCode == 200) {
                  String? jwt = rseponse.data?.idToken;
                  await Configuration.secureStorage.write(key: 'jwt', value: rseponse.data?.idToken);
                  final responseUser = await _openapi.getAccountResourceApi().getAccount(headers: {'Authorization': 'Bearer $jwt'});
                  int? id = responseUser.data?.id;
                  final responseAppUser = await _openapi.getAppUserResourceApi().getAppUserByUserID(id: id!,headers: {'Authorization': 'Bearer $jwt'});
                  if(responseAppUser.statusCode == 200){
                    Configuration.secureStorage.write(key: 'appuserId', value: responseAppUser.data?.id.toString());
                    Configuration.secureStorage.write(key: 'appUsernumber', value: responseAppUser.data?.phoneNumber.toString());
                Navigator.pushReplacement( // Navigate to the home screen if login is successful
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => CameraApp()),
                );
                  }
              } else {
                print('Login failed with status code: ${rseponse.statusCode}');
                print('Response body: ${rseponse.data}');
                // Show an error message if login is unsuccessful
                showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Login Failed'),
                    content: Text('Invalid username or password.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
             }catch (e){
                 print('${e}');
                 showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Login Failed'),
                    content: Text('Invalid username or password.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
             }
            },
            child: Text('Login'),
          ),
          
SizedBox(height: 16.0),
Builder(
  builder: (context) => GestureDetector(
    onTap: () {
      // Navigate to the sign-up page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    },
    child: Text(
      'Don\'t have an account? Sign Up',
      style: TextStyle(color: Colors.blue),
    ),
  ),
),

        ],
      ),
    )
)))));
  }
}