//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/content_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'content_blob_dto.g.dart';

/// ContentBlobDTO
///
/// Properties:
/// * [id] 
/// * [contentBlob] 
/// * [contentBlobContentType] 
/// * [content] 
@BuiltValue()
abstract class ContentBlobDTO implements Built<ContentBlobDTO, ContentBlobDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'contentBlob')
  BuiltList<String>? get contentBlob;

  @BuiltValueField(wireName: r'contentBlobContentType')
  String? get contentBlobContentType;

  @BuiltValueField(wireName: r'content')
  ContentDTO? get content;

  ContentBlobDTO._();

  factory ContentBlobDTO([void updates(ContentBlobDTOBuilder b)]) = _$ContentBlobDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContentBlobDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContentBlobDTO> get serializer => _$ContentBlobDTOSerializer();
}

class _$ContentBlobDTOSerializer implements PrimitiveSerializer<ContentBlobDTO> {
  @override
  final Iterable<Type> types = const [ContentBlobDTO, _$ContentBlobDTO];

  @override
  final String wireName = r'ContentBlobDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContentBlobDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.contentBlob != null) {
      yield r'contentBlob';
      yield serializers.serialize(
        object.contentBlob,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.contentBlobContentType != null) {
      yield r'contentBlobContentType';
      yield serializers.serialize(
        object.contentBlobContentType,
        specifiedType: const FullType(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(ContentDTO),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContentBlobDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContentBlobDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'contentBlob':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.contentBlob.replace(valueDes);
          break;
        case r'contentBlobContentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contentBlobContentType = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ContentDTO),
          ) as ContentDTO;
          result.content.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContentBlobDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContentBlobDTOBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

