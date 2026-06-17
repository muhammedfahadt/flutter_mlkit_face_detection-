import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AuthenticateControllerApi
void main() {
  final instance = Openapi().getAuthenticateControllerApi();

  group(AuthenticateControllerApi, () {
    //Future<JWTToken> authorize(LoginVM loginVM) async
    test('test authorize', () async {
      // TODO
    });

    //Future<String> isAuthenticated() async
    test('test isAuthenticated', () async {
      // TODO
    });

  });
}
