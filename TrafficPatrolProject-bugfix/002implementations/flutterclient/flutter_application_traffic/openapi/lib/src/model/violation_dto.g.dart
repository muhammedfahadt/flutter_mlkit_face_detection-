// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'violation_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ViolationDTO extends ViolationDTO {
  @override
  final int? id;
  @override
  final String? violationType;
  @override
  final PointsDTO? points;
  @override
  final AppUserDTO? appUser;
  @override
  final ContentDTO? content;

  factory _$ViolationDTO([void Function(ViolationDTOBuilder)? updates]) =>
      (new ViolationDTOBuilder()..update(updates))._build();

  _$ViolationDTO._(
      {this.id, this.violationType, this.points, this.appUser, this.content})
      : super._();

  @override
  ViolationDTO rebuild(void Function(ViolationDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ViolationDTOBuilder toBuilder() => new ViolationDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ViolationDTO &&
        id == other.id &&
        violationType == other.violationType &&
        points == other.points &&
        appUser == other.appUser &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, violationType.hashCode);
    _$hash = $jc(_$hash, points.hashCode);
    _$hash = $jc(_$hash, appUser.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ViolationDTO')
          ..add('id', id)
          ..add('violationType', violationType)
          ..add('points', points)
          ..add('appUser', appUser)
          ..add('content', content))
        .toString();
  }
}

class ViolationDTOBuilder
    implements Builder<ViolationDTO, ViolationDTOBuilder> {
  _$ViolationDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _violationType;
  String? get violationType => _$this._violationType;
  set violationType(String? violationType) =>
      _$this._violationType = violationType;

  PointsDTOBuilder? _points;
  PointsDTOBuilder get points => _$this._points ??= new PointsDTOBuilder();
  set points(PointsDTOBuilder? points) => _$this._points = points;

  AppUserDTOBuilder? _appUser;
  AppUserDTOBuilder get appUser => _$this._appUser ??= new AppUserDTOBuilder();
  set appUser(AppUserDTOBuilder? appUser) => _$this._appUser = appUser;

  ContentDTOBuilder? _content;
  ContentDTOBuilder get content => _$this._content ??= new ContentDTOBuilder();
  set content(ContentDTOBuilder? content) => _$this._content = content;

  ViolationDTOBuilder() {
    ViolationDTO._defaults(this);
  }

  ViolationDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _violationType = $v.violationType;
      _points = $v.points?.toBuilder();
      _appUser = $v.appUser?.toBuilder();
      _content = $v.content?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ViolationDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ViolationDTO;
  }

  @override
  void update(void Function(ViolationDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ViolationDTO build() => _build();

  _$ViolationDTO _build() {
    _$ViolationDTO _$result;
    try {
      _$result = _$v ??
          new _$ViolationDTO._(
              id: id,
              violationType: violationType,
              points: _points?.build(),
              appUser: _appUser?.build(),
              content: _content?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'points';
        _points?.build();
        _$failedField = 'appUser';
        _appUser?.build();
        _$failedField = 'content';
        _content?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ViolationDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
