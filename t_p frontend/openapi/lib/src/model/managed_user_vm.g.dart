// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managed_user_vm.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManagedUserVM extends ManagedUserVM {
  @override
  final int? id;
  @override
  final String login;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? imageUrl;
  @override
  final bool? activated;
  @override
  final String? langKey;
  @override
  final String? createdBy;
  @override
  final DateTime? createdDate;
  @override
  final String? lastModifiedBy;
  @override
  final DateTime? lastModifiedDate;
  @override
  final BuiltSet<String>? authorities;
  @override
  final String? password;

  factory _$ManagedUserVM([void Function(ManagedUserVMBuilder)? updates]) =>
      (new ManagedUserVMBuilder()..update(updates))._build();

  _$ManagedUserVM._(
      {this.id,
      required this.login,
      this.firstName,
      this.lastName,
      this.email,
      this.imageUrl,
      this.activated,
      this.langKey,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastModifiedDate,
      this.authorities,
      this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(login, r'ManagedUserVM', 'login');
  }

  @override
  ManagedUserVM rebuild(void Function(ManagedUserVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManagedUserVMBuilder toBuilder() => new ManagedUserVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManagedUserVM &&
        id == other.id &&
        login == other.login &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        imageUrl == other.imageUrl &&
        activated == other.activated &&
        langKey == other.langKey &&
        createdBy == other.createdBy &&
        createdDate == other.createdDate &&
        lastModifiedBy == other.lastModifiedBy &&
        lastModifiedDate == other.lastModifiedDate &&
        authorities == other.authorities &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, login.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, activated.hashCode);
    _$hash = $jc(_$hash, langKey.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, lastModifiedBy.hashCode);
    _$hash = $jc(_$hash, lastModifiedDate.hashCode);
    _$hash = $jc(_$hash, authorities.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ManagedUserVM')
          ..add('id', id)
          ..add('login', login)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('imageUrl', imageUrl)
          ..add('activated', activated)
          ..add('langKey', langKey)
          ..add('createdBy', createdBy)
          ..add('createdDate', createdDate)
          ..add('lastModifiedBy', lastModifiedBy)
          ..add('lastModifiedDate', lastModifiedDate)
          ..add('authorities', authorities)
          ..add('password', password))
        .toString();
  }
}

class ManagedUserVMBuilder
    implements Builder<ManagedUserVM, ManagedUserVMBuilder> {
  _$ManagedUserVM? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _login;
  String? get login => _$this._login;
  set login(String? login) => _$this._login = login;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  bool? _activated;
  bool? get activated => _$this._activated;
  set activated(bool? activated) => _$this._activated = activated;

  String? _langKey;
  String? get langKey => _$this._langKey;
  set langKey(String? langKey) => _$this._langKey = langKey;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  String? _lastModifiedBy;
  String? get lastModifiedBy => _$this._lastModifiedBy;
  set lastModifiedBy(String? lastModifiedBy) =>
      _$this._lastModifiedBy = lastModifiedBy;

  DateTime? _lastModifiedDate;
  DateTime? get lastModifiedDate => _$this._lastModifiedDate;
  set lastModifiedDate(DateTime? lastModifiedDate) =>
      _$this._lastModifiedDate = lastModifiedDate;

  SetBuilder<String>? _authorities;
  SetBuilder<String> get authorities =>
      _$this._authorities ??= new SetBuilder<String>();
  set authorities(SetBuilder<String>? authorities) =>
      _$this._authorities = authorities;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  ManagedUserVMBuilder() {
    ManagedUserVM._defaults(this);
  }

  ManagedUserVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _login = $v.login;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _imageUrl = $v.imageUrl;
      _activated = $v.activated;
      _langKey = $v.langKey;
      _createdBy = $v.createdBy;
      _createdDate = $v.createdDate;
      _lastModifiedBy = $v.lastModifiedBy;
      _lastModifiedDate = $v.lastModifiedDate;
      _authorities = $v.authorities?.toBuilder();
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ManagedUserVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ManagedUserVM;
  }

  @override
  void update(void Function(ManagedUserVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManagedUserVM build() => _build();

  _$ManagedUserVM _build() {
    _$ManagedUserVM _$result;
    try {
      _$result = _$v ??
          new _$ManagedUserVM._(
              id: id,
              login: BuiltValueNullFieldError.checkNotNull(
                  login, r'ManagedUserVM', 'login'),
              firstName: firstName,
              lastName: lastName,
              email: email,
              imageUrl: imageUrl,
              activated: activated,
              langKey: langKey,
              createdBy: createdBy,
              createdDate: createdDate,
              lastModifiedBy: lastModifiedBy,
              lastModifiedDate: lastModifiedDate,
              authorities: _authorities?.build(),
              password: password);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authorities';
        _authorities?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ManagedUserVM', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
