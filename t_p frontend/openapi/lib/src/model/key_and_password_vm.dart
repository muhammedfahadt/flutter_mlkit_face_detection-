//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'key_and_password_vm.g.dart';

/// KeyAndPasswordVM
///
/// Properties:
/// * [key] 
/// * [newPassword] 
@BuiltValue()
abstract class KeyAndPasswordVM implements Built<KeyAndPasswordVM, KeyAndPasswordVMBuilder> {
  @BuiltValueField(wireName: r'key')
  String? get key;

  @BuiltValueField(wireName: r'newPassword')
  String? get newPassword;

  KeyAndPasswordVM._();

  factory KeyAndPasswordVM([void updates(KeyAndPasswordVMBuilder b)]) = _$KeyAndPasswordVM;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KeyAndPasswordVMBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KeyAndPasswordVM> get serializer => _$KeyAndPasswordVMSerializer();
}

class _$KeyAndPasswordVMSerializer implements PrimitiveSerializer<KeyAndPasswordVM> {
  @override
  final Iterable<Type> types = const [KeyAndPasswordVM, _$KeyAndPasswordVM];

  @override
  final String wireName = r'KeyAndPasswordVM';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KeyAndPasswordVM object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.key != null) {
      yield r'key';
      yield serializers.serialize(
        object.key,
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
    KeyAndPasswordVM object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KeyAndPasswordVMBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.key = valueDes;
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
  KeyAndPasswordVM deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KeyAndPasswordVMBuilder();
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

