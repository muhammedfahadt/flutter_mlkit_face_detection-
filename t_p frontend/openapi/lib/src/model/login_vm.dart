//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_vm.g.dart';

/// LoginVM
///
/// Properties:
/// * [username] 
/// * [password] 
/// * [rememberMe] 
@BuiltValue()
abstract class LoginVM implements Built<LoginVM, LoginVMBuilder> {
  @BuiltValueField(wireName: r'username')
  String get username;

  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'rememberMe')
  bool? get rememberMe;

  LoginVM._();

  factory LoginVM([void updates(LoginVMBuilder b)]) = _$LoginVM;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginVMBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginVM> get serializer => _$LoginVMSerializer();
}

class _$LoginVMSerializer implements PrimitiveSerializer<LoginVM> {
  @override
  final Iterable<Type> types = const [LoginVM, _$LoginVM];

  @override
  final String wireName = r'LoginVM';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginVM object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.rememberMe != null) {
      yield r'rememberMe';
      yield serializers.serialize(
        object.rememberMe,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginVM object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginVMBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'rememberMe':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.rememberMe = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginVM deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginVMBuilder();
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

