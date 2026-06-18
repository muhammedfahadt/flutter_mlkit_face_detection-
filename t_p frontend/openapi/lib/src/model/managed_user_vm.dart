//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'managed_user_vm.g.dart';

/// ManagedUserVM
///
/// Properties:
/// * [id] 
/// * [login] 
/// * [firstName] 
/// * [lastName] 
/// * [email] 
/// * [imageUrl] 
/// * [activated] 
/// * [langKey] 
/// * [createdBy] 
/// * [createdDate] 
/// * [lastModifiedBy] 
/// * [lastModifiedDate] 
/// * [authorities] 
/// * [password] 
@BuiltValue()
abstract class ManagedUserVM implements Built<ManagedUserVM, ManagedUserVMBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'login')
  String get login;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  @BuiltValueField(wireName: r'activated')
  bool? get activated;

  @BuiltValueField(wireName: r'langKey')
  String? get langKey;

  @BuiltValueField(wireName: r'createdBy')
  String? get createdBy;

  @BuiltValueField(wireName: r'createdDate')
  DateTime? get createdDate;

  @BuiltValueField(wireName: r'lastModifiedBy')
  String? get lastModifiedBy;

  @BuiltValueField(wireName: r'lastModifiedDate')
  DateTime? get lastModifiedDate;

  @BuiltValueField(wireName: r'authorities')
  BuiltSet<String>? get authorities;

  @BuiltValueField(wireName: r'password')
  String? get password;

  ManagedUserVM._();

  factory ManagedUserVM([void updates(ManagedUserVMBuilder b)]) = _$ManagedUserVM;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ManagedUserVMBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ManagedUserVM> get serializer => _$ManagedUserVMSerializer();
}

class _$ManagedUserVMSerializer implements PrimitiveSerializer<ManagedUserVM> {
  @override
  final Iterable<Type> types = const [ManagedUserVM, _$ManagedUserVM];

  @override
  final String wireName = r'ManagedUserVM';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ManagedUserVM object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    yield r'login';
    yield serializers.serialize(
      object.login,
      specifiedType: const FullType(String),
    );
    if (object.firstName != null) {
      yield r'firstName';
      yield serializers.serialize(
        object.firstName,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastName != null) {
      yield r'lastName';
      yield serializers.serialize(
        object.lastName,
        specifiedType: const FullType(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.imageUrl != null) {
      yield r'imageUrl';
      yield serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.activated != null) {
      yield r'activated';
      yield serializers.serialize(
        object.activated,
        specifiedType: const FullType(bool),
      );
    }
    if (object.langKey != null) {
      yield r'langKey';
      yield serializers.serialize(
        object.langKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdBy != null) {
      yield r'createdBy';
      yield serializers.serialize(
        object.createdBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdDate != null) {
      yield r'createdDate';
      yield serializers.serialize(
        object.createdDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.lastModifiedBy != null) {
      yield r'lastModifiedBy';
      yield serializers.serialize(
        object.lastModifiedBy,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastModifiedDate != null) {
      yield r'lastModifiedDate';
      yield serializers.serialize(
        object.lastModifiedDate,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.authorities != null) {
      yield r'authorities';
      yield serializers.serialize(
        object.authorities,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ManagedUserVM object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ManagedUserVMBuilder result,
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
        case r'login':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.login = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastName = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        case r'activated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.activated = valueDes;
          break;
        case r'langKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.langKey = valueDes;
          break;
        case r'createdBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdBy = valueDes;
          break;
        case r'createdDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdDate = valueDes;
          break;
        case r'lastModifiedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastModifiedBy = valueDes;
          break;
        case r'lastModifiedDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastModifiedDate = valueDes;
          break;
        case r'authorities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.authorities.replace(valueDes);
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ManagedUserVM deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ManagedUserVMBuilder();
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

