//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/content_dto.dart';
import 'package:openapi/src/model/points_dto.dart';
import 'package:openapi/src/model/app_user_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'violation_dto.g.dart';

/// ViolationDTO
///
/// Properties:
/// * [id] 
/// * [violationType] 
/// * [points] 
/// * [appUser] 
/// * [content] 
@BuiltValue()
abstract class ViolationDTO implements Built<ViolationDTO, ViolationDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'violationType')
  String? get violationType;

  @BuiltValueField(wireName: r'points')
  PointsDTO? get points;

  @BuiltValueField(wireName: r'appUser')
  AppUserDTO? get appUser;

  @BuiltValueField(wireName: r'content')
  ContentDTO? get content;

  ViolationDTO._();

  factory ViolationDTO([void updates(ViolationDTOBuilder b)]) = _$ViolationDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ViolationDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ViolationDTO> get serializer => _$ViolationDTOSerializer();
}

class _$ViolationDTOSerializer implements PrimitiveSerializer<ViolationDTO> {
  @override
  final Iterable<Type> types = const [ViolationDTO, _$ViolationDTO];

  @override
  final String wireName = r'ViolationDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ViolationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.violationType != null) {
      yield r'violationType';
      yield serializers.serialize(
        object.violationType,
        specifiedType: const FullType(String),
      );
    }
    if (object.points != null) {
      yield r'points';
      yield serializers.serialize(
        object.points,
        specifiedType: const FullType(PointsDTO),
      );
    }
    if (object.appUser != null) {
      yield r'appUser';
      yield serializers.serialize(
        object.appUser,
        specifiedType: const FullType(AppUserDTO),
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
    ViolationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ViolationDTOBuilder result,
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
        case r'violationType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.violationType = valueDes;
          break;
        case r'points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PointsDTO),
          ) as PointsDTO;
          result.points.replace(valueDes);
          break;
        case r'appUser':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AppUserDTO),
          ) as AppUserDTO;
          result.appUser.replace(valueDes);
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
  ViolationDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ViolationDTOBuilder();
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

