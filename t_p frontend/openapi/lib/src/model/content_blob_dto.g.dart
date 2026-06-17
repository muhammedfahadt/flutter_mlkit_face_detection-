// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_blob_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContentBlobDTO extends ContentBlobDTO {
  @override
  final int? id;
  @override
  final BuiltList<String>? contentBlob;
  @override
  final String? contentBlobContentType;
  @override
  final ContentDTO? content;

  factory _$ContentBlobDTO([void Function(ContentBlobDTOBuilder)? updates]) =>
      (new ContentBlobDTOBuilder()..update(updates))._build();

  _$ContentBlobDTO._(
      {this.id, this.contentBlob, this.contentBlobContentType, this.content})
      : super._();

  @override
  ContentBlobDTO rebuild(void Function(ContentBlobDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContentBlobDTOBuilder toBuilder() =>
      new ContentBlobDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContentBlobDTO &&
        id == other.id &&
        contentBlob == other.contentBlob &&
        contentBlobContentType == other.contentBlobContentType &&
        content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, contentBlob.hashCode);
    _$hash = $jc(_$hash, contentBlobContentType.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContentBlobDTO')
          ..add('id', id)
          ..add('contentBlob', contentBlob)
          ..add('contentBlobContentType', contentBlobContentType)
          ..add('content', content))
        .toString();
  }
}

class ContentBlobDTOBuilder
    implements Builder<ContentBlobDTO, ContentBlobDTOBuilder> {
  _$ContentBlobDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ListBuilder<String>? _contentBlob;
  ListBuilder<String> get contentBlob =>
      _$this._contentBlob ??= new ListBuilder<String>();
  set contentBlob(ListBuilder<String>? contentBlob) =>
      _$this._contentBlob = contentBlob;

  String? _contentBlobContentType;
  String? get contentBlobContentType => _$this._contentBlobContentType;
  set contentBlobContentType(String? contentBlobContentType) =>
      _$this._contentBlobContentType = contentBlobContentType;

  ContentDTOBuilder? _content;
  ContentDTOBuilder get content => _$this._content ??= new ContentDTOBuilder();
  set content(ContentDTOBuilder? content) => _$this._content = content;

  ContentBlobDTOBuilder() {
    ContentBlobDTO._defaults(this);
  }

  ContentBlobDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _contentBlob = $v.contentBlob?.toBuilder();
      _contentBlobContentType = $v.contentBlobContentType;
      _content = $v.content?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContentBlobDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ContentBlobDTO;
  }

  @override
  void update(void Function(ContentBlobDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContentBlobDTO build() => _build();

  _$ContentBlobDTO _build() {
    _$ContentBlobDTO _$result;
    try {
      _$result = _$v ??
          new _$ContentBlobDTO._(
              id: id,
              contentBlob: _contentBlob?.build(),
              contentBlobContentType: contentBlobContentType,
              content: _content?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contentBlob';
        _contentBlob?.build();

        _$failedField = 'content';
        _content?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ContentBlobDTO', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
