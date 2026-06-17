import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for PublicUserResourceApi
void main() {
  final instance = Openapi().getPublicUserResourceApi();

  group(PublicUserResourceApi, () {
    //Future<BuiltList<UserDTO>> getAllPublicUsers({ int page, int size, BuiltList<String> sort }) async
    test('test getAllPublicUsers', () async {
      // TODO
    });

    //Future<BuiltList<String>> getAuthorities() async
    test('test getAuthorities', () async {
      // TODO
    });

  });
}
