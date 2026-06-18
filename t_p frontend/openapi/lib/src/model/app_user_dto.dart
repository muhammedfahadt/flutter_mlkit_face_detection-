//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_user_dto.g.dart';

/// AppUserDTO
///
/// Properties:
/// * [id] 
/// * [phoneNumber] 
/// * [address] 
/// * [pinCode] 
/// * [user] 
@BuiltValue()
abstract class AppUserDTO implements Built<AppUserDTO, AppUserDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'phoneNumber')
  int? get phoneNumber;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'pinCode')
  int? get pinCode;

  @BuiltValueField(wireName: r'user')
  UserDTO? get user;

  AppUserDTO._();

  factory AppUserDTO([void updates(AppUserDTOBuilder b)]) = _$AppUserDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AppUserDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AppUserDTO> get serializer => _$AppUserDTOSerializer();
}

class _$AppUserDTOSerializer implements PrimitiveSerializer<AppUserDTO> {
  @override
  final Iterable<Type> types = const [AppUserDTO, _$AppUserDTO];

  @override
  final String wireName = r'AppUserDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AppUserDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.phoneNumber != null) {
      yield r'phoneNumber';
      yield serializers.serialize(
        object.phoneNumber,
        specifiedType: const FullType(int),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
    if (object.pinCode != null) {
      yield r'pinCode';
      yield serializers.serialize(
        object.pinCode,
        specifiedType: const FullType(int),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(UserDTO),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AppUserDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AppUserDTOBuilder result,
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
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.phoneNumber = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'pinCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pinCode = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserDTO),
          ) as UserDTO;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AppUserDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AppUserDTOBuilder();
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

