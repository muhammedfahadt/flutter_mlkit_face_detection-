// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_and_password_vm.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KeyAndPasswordVM extends KeyAndPasswordVM {
  @override
  final String? key;
  @override
  final String? newPassword;

  factory _$KeyAndPasswordVM(
          [void Function(KeyAndPasswordVMBuilder)? updates]) =>
      (new KeyAndPasswordVMBuilder()..update(updates))._build();

  _$KeyAndPasswordVM._({this.key, this.newPassword}) : super._();

  @override
  KeyAndPasswordVM rebuild(void Function(KeyAndPasswordVMBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KeyAndPasswordVMBuilder toBuilder() =>
      new KeyAndPasswordVMBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KeyAndPasswordVM &&
        key == other.key &&
        newPassword == other.newPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KeyAndPasswordVM')
          ..add('key', key)
          ..add('newPassword', newPassword))
        .toString();
  }
}

class KeyAndPasswordVMBuilder
    implements Builder<KeyAndPasswordVM, KeyAndPasswordVMBuilder> {
  _$KeyAndPasswordVM? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  KeyAndPasswordVMBuilder() {
    KeyAndPasswordVM._defaults(this);
  }

  KeyAndPasswordVMBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _newPassword = $v.newPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KeyAndPasswordVM other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$KeyAndPasswordVM;
  }

  @override
  void update(void Function(KeyAndPasswordVMBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KeyAndPasswordVM build() => _build();

  _$KeyAndPasswordVM _build() {
    final _$result =
        _$v ?? new _$KeyAndPasswordVM._(key: key, newPassword: newPassword);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
