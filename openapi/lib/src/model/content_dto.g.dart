// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContentDTO extends ContentDTO {
  @override
  final int? id;
  @override
  final String? contentType;
  @override
  final DateTime? uploadDateTime;
  @override
  final String? status;
  @override
  final AppUserDTO? appUser;

  factory _$ContentDTO([void Function(ContentDTOBuilder)? updates]) =>
      (new ContentDTOBuilder()..update(updates))._build();

  _$ContentDTO._(
      {this.id,
      this.contentType,
      this.uploadDateTime,
      this.status,
      this.appUser})
      : super._();

  @override
  ContentDTO rebuild(void Function(ContentDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContentDTOBuilder toBuilder() => new ContentDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContentDTO &&
        id == other.id &&
        contentType == other.contentType &&
        uploadDateTime == other.uploadDateTime &&
        status == other.status &&
        appUser == other.appUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, uploadDateTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, appUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContentDTO')
          ..add('id', id)
          ..add('contentType', contentType)
          ..add('uploadDateTime', uploadDateTime)
          ..add('status', status)
          ..add('appUser', appUser))
        .toString();
  }
}

class ContentDTOBuilder implements Builder<ContentDTO, ContentDTOBuilder> {
  _$ContentDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _contentType;
  String? get contentType => _$this._contentType;
  set contentType(String? contentType) => _$this._contentType = contentType;

  DateTime? _uploadDateTime;
  DateTime? get uploadDateTime => _$this._uploadDateTime;
  set uploadDateTime(DateTime? uploadDateTime) =>
      _$this._uploadDateTime = uploadDateTime;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  AppUserDTOBuilder? _appUser;
  AppUserDTOBuilder get appUser => _$this._appUser ??= new AppUserDTOBuilder();
  set appUser(AppUserDTOBuilder? appUser) => _$this._appUser = appUser;

  ContentDTOBuilder() {
    ContentDTO._defaults(this);
  }

  ContentDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _contentType = $v.contentType;
      _uploadDateTime = $v.uploadDateTime;
      _status = $v.status;
      _appUser = $v.appUser?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContentDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ContentDTO;
  }

  @override
  void update(void Function(ContentDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContentDTO build() => _build();

  _$ContentDTO _build() {
    _$ContentDTO _$result;
    try {
      _$result = _$v ??
          new _$ContentDTO._(
              id: id,
              contentType: contentType,
              uploadDateTime: uploadDateTime,
              status: status,
              appUser: _appUser?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'appUser';
        _appUser?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ContentDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
