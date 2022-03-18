// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bu_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BuFile _$BuFileFromJson(Map<String, dynamic> json) {
  return _BuFile.fromJson(json);
}

/// @nodoc
class _$BuFileTearOff {
  const _$BuFileTearOff();

  _BuFile call(
      {@JsonKey(name: "name") required String filename,
      @JsonKey(name: "content") String? base64content}) {
    return _BuFile(
      filename: filename,
      base64content: base64content,
    );
  }

  BuFile fromJson(Map<String, Object?> json) {
    return BuFile.fromJson(json);
  }
}

/// @nodoc
const $BuFile = _$BuFileTearOff();

/// @nodoc
mixin _$BuFile {
  @JsonKey(name: "name")
  String get filename => throw _privateConstructorUsedError;
  @JsonKey(name: "content")
  String? get base64content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuFileCopyWith<BuFile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuFileCopyWith<$Res> {
  factory $BuFileCopyWith(BuFile value, $Res Function(BuFile) then) =
      _$BuFileCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "name") String filename,
      @JsonKey(name: "content") String? base64content});
}

/// @nodoc
class _$BuFileCopyWithImpl<$Res> implements $BuFileCopyWith<$Res> {
  _$BuFileCopyWithImpl(this._value, this._then);

  final BuFile _value;
  // ignore: unused_field
  final $Res Function(BuFile) _then;

  @override
  $Res call({
    Object? filename = freezed,
    Object? base64content = freezed,
  }) {
    return _then(_value.copyWith(
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      base64content: base64content == freezed
          ? _value.base64content
          : base64content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$BuFileCopyWith<$Res> implements $BuFileCopyWith<$Res> {
  factory _$BuFileCopyWith(_BuFile value, $Res Function(_BuFile) then) =
      __$BuFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "name") String filename,
      @JsonKey(name: "content") String? base64content});
}

/// @nodoc
class __$BuFileCopyWithImpl<$Res> extends _$BuFileCopyWithImpl<$Res>
    implements _$BuFileCopyWith<$Res> {
  __$BuFileCopyWithImpl(_BuFile _value, $Res Function(_BuFile) _then)
      : super(_value, (v) => _then(v as _BuFile));

  @override
  _BuFile get _value => super._value as _BuFile;

  @override
  $Res call({
    Object? filename = freezed,
    Object? base64content = freezed,
  }) {
    return _then(_BuFile(
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      base64content: base64content == freezed
          ? _value.base64content
          : base64content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BuFile with DiagnosticableTreeMixin implements _BuFile {
  const _$_BuFile(
      {@JsonKey(name: "name") required this.filename,
      @JsonKey(name: "content") this.base64content});

  factory _$_BuFile.fromJson(Map<String, dynamic> json) =>
      _$$_BuFileFromJson(json);

  @override
  @JsonKey(name: "name")
  final String filename;
  @override
  @JsonKey(name: "content")
  final String? base64content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BuFile(filename: $filename, base64content: $base64content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BuFile'))
      ..add(DiagnosticsProperty('filename', filename))
      ..add(DiagnosticsProperty('base64content', base64content));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuFile &&
            const DeepCollectionEquality().equals(other.filename, filename) &&
            const DeepCollectionEquality()
                .equals(other.base64content, base64content));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filename),
      const DeepCollectionEquality().hash(base64content));

  @JsonKey(ignore: true)
  @override
  _$BuFileCopyWith<_BuFile> get copyWith =>
      __$BuFileCopyWithImpl<_BuFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuFileToJson(this);
  }
}

abstract class _BuFile implements BuFile {
  const factory _BuFile(
      {@JsonKey(name: "name") required String filename,
      @JsonKey(name: "content") String? base64content}) = _$_BuFile;

  factory _BuFile.fromJson(Map<String, dynamic> json) = _$_BuFile.fromJson;

  @override
  @JsonKey(name: "name")
  String get filename;
  @override
  @JsonKey(name: "content")
  String? get base64content;
  @override
  @JsonKey(ignore: true)
  _$BuFileCopyWith<_BuFile> get copyWith => throw _privateConstructorUsedError;
}
