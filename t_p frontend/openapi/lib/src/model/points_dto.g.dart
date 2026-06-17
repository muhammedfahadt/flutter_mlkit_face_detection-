// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PointsDTO extends PointsDTO {
  @override
  final int? id;
  @override
  final int? pointsEarned;
  @override
  final DateTime? uploadDateTime;
  @override
  final AppUserDTO? appUser;

  factory _$PointsDTO([void Function(PointsDTOBuilder)? updates]) =>
      (new PointsDTOBuilder()..update(updates))._build();

  _$PointsDTO._({this.id, this.pointsEarned, this.uploadDateTime, this.appUser})
      : super._();

  @override
  PointsDTO rebuild(void Function(PointsDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PointsDTOBuilder toBuilder() => new PointsDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PointsDTO &&
        id == other.id &&
        pointsEarned == other.pointsEarned &&
        uploadDateTime == other.uploadDateTime &&
        appUser == other.appUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, pointsEarned.hashCode);
    _$hash = $jc(_$hash, uploadDateTime.hashCode);
    _$hash = $jc(_$hash, appUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PointsDTO')
          ..add('id', id)
          ..add('pointsEarned', pointsEarned)
          ..add('uploadDateTime', uploadDateTime)
          ..add('appUser', appUser))
        .toString();
  }
}

class PointsDTOBuilder implements Builder<PointsDTO, PointsDTOBuilder> {
  _$PointsDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _pointsEarned;
  int? get pointsEarned => _$this._pointsEarned;
  set pointsEarned(int? pointsEarned) => _$this._pointsEarned = pointsEarned;

  DateTime? _uploadDateTime;
  DateTime? get uploadDateTime => _$this._uploadDateTime;
  set uploadDateTime(DateTime? uploadDateTime) =>
      _$this._uploadDateTime = uploadDateTime;

  AppUserDTOBuilder? _appUser;
  AppUserDTOBuilder get appUser => _$this._appUser ??= new AppUserDTOBuilder();
  set appUser(AppUserDTOBuilder? appUser) => _$this._appUser = appUser;

  PointsDTOBuilder() {
    PointsDTO._defaults(this);
  }

  PointsDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _pointsEarned = $v.pointsEarned;
      _uploadDateTime = $v.uploadDateTime;
      _appUser = $v.appUser?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PointsDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PointsDTO;
  }

  @override
  void update(void Function(PointsDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PointsDTO build() => _build();

  _$PointsDTO _build() {
    _$PointsDTO _$result;
    try {
      _$result = _$v ??
          new _$PointsDTO._(
              id: id,
              pointsEarned: pointsEarned,
              uploadDateTime: uploadDateTime,
              appUser: _appUser?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'appUser';
        _appUser?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PointsDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
