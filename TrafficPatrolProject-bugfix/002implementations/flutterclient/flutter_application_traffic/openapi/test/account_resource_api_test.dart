import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for AccountResourceApi
void main() {
  final instance = Openapi().getAccountResourceApi();

  group(AccountResourceApi, () {
    //Future activateAccount(String key) async
    test('test activateAccount', () async {
      // TODO
    });

    //Future changePassword(PasswordChangeDTO passwordChangeDTO) async
    test('test changePassword', () async {
      // TODO
    });

    //Future finishPasswordReset(KeyAndPasswordVM keyAndPasswordVM) async
    test('test finishPasswordReset', () async {
      // TODO
    });

    //Future<AdminUserDTO> getAccount() async
    test('test getAccount', () async {
      // TODO
    });

    //Future registerAccount(ManagedUserVM managedUserVM) async
    test('test registerAccount', () async {
      // TODO
    });

    //Future requestPasswordReset(String body) async
    test('test requestPasswordReset', () async {
      // TODO
    });

    //Future saveAccount(AdminUserDTO adminUserDTO) async
    test('test saveAccount', () async {
      // TODO
    });

  });
}
