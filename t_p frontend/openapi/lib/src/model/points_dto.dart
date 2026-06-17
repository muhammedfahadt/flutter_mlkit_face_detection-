//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/app_user_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'points_dto.g.dart';

/// PointsDTO
///
/// Properties:
/// * [id] 
/// * [pointsEarned] 
/// * [uploadDateTime] 
/// * [appUser] 
@BuiltValue()
abstract class PointsDTO implements Built<PointsDTO, PointsDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'pointsEarned')
  int? get pointsEarned;

  @BuiltValueField(wireName: r'uploadDateTime')
  DateTime? get uploadDateTime;

  @BuiltValueField(wireName: r'appUser')
  AppUserDTO? get appUser;

  PointsDTO._();

  factory PointsDTO([void updates(PointsDTOBuilder b)]) = _$PointsDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PointsDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PointsDTO> get serializer => _$PointsDTOSerializer();
}

class _$PointsDTOSerializer implements PrimitiveSerializer<PointsDTO> {
  @override
  final Iterable<Type> types = const [PointsDTO, _$PointsDTO];

  @override
  final String wireName = r'PointsDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PointsDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.pointsEarned != null) {
      yield r'pointsEarned';
      yield serializers.serialize(
        object.pointsEarned,
        specifiedType: const FullType(int),
      );
    }
    if (object.uploadDateTime != null) {
      yield r'uploadDateTime';
      yield serializers.serialize(
        object.uploadDateTime,
        specifiedType: const FullType(DateTime),
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
    PointsDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PointsDTOBuilder result,
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
        case r'pointsEarned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pointsEarned = valueDes;
          break;
        case r'uploadDateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.uploadDateTime = valueDes;
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
  PointsDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PointsDTOBuilder();
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

