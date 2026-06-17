import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for UserResourceApi
void main() {
  final instance = Openapi().getUserResourceApi();

  group(UserResourceApi, () {
    //Future<User> createUser(AdminUserDTO adminUserDTO) async
    test('test createUser', () async {
      // TODO
    });

    //Future deleteUser(String login) async
    test('test deleteUser', () async {
      // TODO
    });

    //Future<BuiltList<AdminUserDTO>> getAllUsers({ int page, int size, BuiltList<String> sort }) async
    test('test getAllUsers', () async {
      // TODO
    });

    //Future<AdminUserDTO> getUser(String login) async
    test('test getUser', () async {
      // TODO
    });

    //Future<AdminUserDTO> updateUser(AdminUserDTO adminUserDTO) async
    test('test updateUser', () async {
      // TODO
    });

  });
}
