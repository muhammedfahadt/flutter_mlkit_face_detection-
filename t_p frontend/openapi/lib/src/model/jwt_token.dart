//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'jwt_token.g.dart';

/// JWTToken
///
/// Properties:
/// * [idToken] 
@BuiltValue()
abstract class JWTToken implements Built<JWTToken, JWTTokenBuilder> {
  @BuiltValueField(wireName: r'id_token')
  String? get idToken;

  JWTToken._();

  factory JWTToken([void updates(JWTTokenBuilder b)]) = _$JWTToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JWTTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JWTToken> get serializer => _$JWTTokenSerializer();
}

class _$JWTTokenSerializer implements PrimitiveSerializer<JWTToken> {
  @override
  final Iterable<Type> types = const [JWTToken, _$JWTToken];

  @override
  final String wireName = r'JWTToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JWTToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.idToken != null) {
      yield r'id_token';
      yield serializers.serialize(
        object.idToken,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    JWTToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required JWTTokenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  JWTToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JWTTokenBuilder();
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

