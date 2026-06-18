//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/app_user_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'content_dto.g.dart';

/// ContentDTO
///
/// Properties:
/// * [id] 
/// * [contentType] 
/// * [uploadDateTime] 
/// * [status] 
/// * [appUser] 
@BuiltValue()
abstract class ContentDTO implements Built<ContentDTO, ContentDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'contentType')
  String? get contentType;

  @BuiltValueField(wireName: r'uploadDateTime')
  DateTime? get uploadDateTime;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'appUser')
  AppUserDTO? get appUser;

  ContentDTO._();

  factory ContentDTO([void updates(ContentDTOBuilder b)]) = _$ContentDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContentDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContentDTO> get serializer => _$ContentDTOSerializer();
}

class _$ContentDTOSerializer implements PrimitiveSerializer<ContentDTO> {
  @override
  final Iterable<Type> types = const [ContentDTO, _$ContentDTO];

  @override
  final String wireName = r'ContentDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContentDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.contentType != null) {
      yield r'contentType';
      yield serializers.serialize(
        object.contentType,
        specifiedType: const FullType(String),
      );
    }
    if (object.uploadDateTime != null) {
      yield r'uploadDateTime';
      yield serializers.serialize(
        object.uploadDateTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.appUser != null) {
      yield r'appUser';
      yield serializers.serialize(
        object.appUser,
        specifiedType: const FullType(AppUserDTO),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ContentDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContentDTOBuilder result,
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
        case r'contentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contentType = valueDes;
          break;
        case r'uploadDateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.uploadDateTime = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'appUser':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AppUserDTO),
          ) as AppUserDTO;
          result.appUser.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContentDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContentDTOBuilder();
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

