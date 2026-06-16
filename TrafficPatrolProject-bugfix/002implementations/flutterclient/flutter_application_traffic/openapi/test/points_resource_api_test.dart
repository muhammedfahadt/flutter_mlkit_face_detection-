import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for PointsResourceApi
void main() {
  final instance = Openapi().getPointsResourceApi();

  group(PointsResourceApi, () {
    //Future<PointsDTO> createPoints(PointsDTO pointsDTO) async
    test('test createPoints', () async {
      // TODO
    });

    //Future deletePoints(int id) async
    test('test deletePoints', () async {
      // TODO
    });

    //Future<BuiltList<PointsDTO>> getAllPoints({ String filter }) async
    test('test getAllPoints', () async {
      // TODO
    });

    //Future<PointsDTO> getPoints(int id) async
    test('test getPoints', () async {
      // TODO
    });

    //Future<PointsDTO> partialUpdatePoints(int id, PointsDTO pointsDTO) async
    test('test partialUpdatePoints', () async {
      // TODO
    });

    //Future<PointsDTO> updatePoints(int id, PointsDTO pointsDTO) async
    test('test updatePoints', () async {
      // TODO
    });

  });
}
