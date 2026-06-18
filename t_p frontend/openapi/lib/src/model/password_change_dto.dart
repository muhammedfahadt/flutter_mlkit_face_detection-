//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'password_change_dto.g.dart';

/// PasswordChangeDTO
///
/// Properties:
/// * [currentPassword] 
/// * [newPassword] 
@BuiltValue()
abstract class PasswordChangeDTO implements Built<PasswordChangeDTO, PasswordChangeDTOBuilder> {
  @BuiltValueField(wireName: r'currentPassword')
  String? get currentPassword;

  @BuiltValueField(wireName: r'newPassword')
  String? get newPassword;

  PasswordChangeDTO._();

  factory PasswordChangeDTO([void updates(PasswordChangeDTOBuilder b)]) = _$PasswordChangeDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PasswordChangeDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PasswordChangeDTO> get serializer => _$PasswordChangeDTOSerializer();
}

class _$PasswordChangeDTOSerializer implements PrimitiveSerializer<PasswordChangeDTO> {
  @override
  final Iterable<Type> types = const [PasswordChangeDTO, _$PasswordChangeDTO];

  @override
  final String wireName = r'PasswordChangeDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PasswordChangeDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.currentPassword != null) {
      yield r'currentPassword';
      yield serializers.serialize(
        object.currentPassword,
        specifiedType: const FullType(String),
      );
    }
    if (object.newPassword != null) {
      yield r'newPassword';
      yield serializers.serialize(
        object.newPassword,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PasswordChangeDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PasswordChangeDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'currentPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currentPassword = valueDes;
          break;
        case r'newPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PasswordChangeDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PasswordChangeDTOBuilder();
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

