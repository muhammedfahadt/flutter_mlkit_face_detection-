import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ContentResourceApi
void main() {
  final instance = Openapi().getContentResourceApi();

  group(ContentResourceApi, () {
    //Future<ContentDTO> createContent(ContentDTO contentDTO) async
    test('test createContent', () async {
      // TODO
    });

    //Future deleteContent(int id) async
    test('test deleteContent', () async {
      // TODO
    });

    //Future<BuiltList<ContentDTO>> getAllContents() async
    test('test getAllContents', () async {
      // TODO
    });

    //Future<ContentDTO> getContent(int id) async
    test('test getContent', () async {
      // TODO
    });

    //Future<ContentDTO> partialUpdateContent(int id, ContentDTO contentDTO) async
    test('test partialUpdateContent', () async {
      // TODO
    });

    //Future<ContentDTO> updateContent(int id, ContentDTO contentDTO) async
    test('test updateContent', () async {
      // TODO
    });

  });
}
