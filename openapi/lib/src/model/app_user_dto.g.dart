// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppUserDTO extends AppUserDTO {
  @override
  final int? id;
  @override
  final int? phoneNumber;
  @override
  final String? address;
  @override
  final int? pinCode;
  @override
  final UserDTO? user;

  factory _$AppUserDTO([void Function(AppUserDTOBuilder)? updates]) =>
      (new AppUserDTOBuilder()..update(updates))._build();

  _$AppUserDTO._(
      {this.id, this.phoneNumber, this.address, this.pinCode, this.user})
      : super._();

  @override
  AppUserDTO rebuild(void Function(AppUserDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppUserDTOBuilder toBuilder() => new AppUserDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppUserDTO &&
        id == other.id &&
        phoneNumber == other.phoneNumber &&
        address == other.address &&
        pinCode == other.pinCode &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, pinCode.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppUserDTO')
          ..add('id', id)
          ..add('phoneNumber', phoneNumber)
          ..add('address', address)
          ..add('pinCode', pinCode)
          ..add('user', user))
        .toString();
  }
}

class AppUserDTOBuilder implements Builder<AppUserDTO, AppUserDTOBuilder> {
  _$AppUserDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _phoneNumber;
  int? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(int? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  int? _pinCode;
  int? get pinCode => _$this._pinCode;
  set pinCode(int? pinCode) => _$this._pinCode = pinCode;

  UserDTOBuilder? _user;
  UserDTOBuilder get user => _$this._user ??= new UserDTOBuilder();
  set user(UserDTOBuilder? user) => _$this._user = user;

  AppUserDTOBuilder() {
    AppUserDTO._defaults(this);
  }

  AppUserDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _phoneNumber = $v.phoneNumber;
      _address = $v.address;
      _pinCode = $v.pinCode;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppUserDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppUserDTO;
  }

  @override
  void update(void Function(AppUserDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppUserDTO build() => _build();

  _$AppUserDTO _build() {
    _$AppUserDTO _$result;
    try {
      _$result = _$v ??
          new _$AppUserDTO._(
              id: id,
              phoneNumber: phoneNumber,
              address: address,
              pinCode: pinCode,
              user: _user?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppUserDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
