import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ViolationResourceApi
void main() {
  final instance = Openapi().getViolationResourceApi();

  group(ViolationResourceApi, () {
    //Future<ViolationDTO> createViolation(ViolationDTO violationDTO) async
    test('test createViolation', () async {
      // TODO
    });

    //Future deleteViolation(int id) async
    test('test deleteViolation', () async {
      // TODO
    });

    //Future<BuiltList<ViolationDTO>> getAllViolations() async
    test('test getAllViolations', () async {
      // TODO
    });

    //Future<ViolationDTO> getViolation(int id) async
    test('test getViolation', () async {
      // TODO
    });

    //Future<ViolationDTO> partialUpdateViolation(int id, ViolationDTO violationDTO) async
    test('test partialUpdateViolation', () async {
      // TODO
    });

    //Future<ViolationDTO> updateViolation(int id, ViolationDTO violationDTO) async
    test('test updateViolation', () async {
      // TODO
    });

  });
}
