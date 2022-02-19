// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bu_builder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BuBuilder _$BuBuilderFromJson(Map<String, dynamic> json) {
  return _BuBuilder.fromJson(json);
}

/// @nodoc
class _$BuBuilderTearOff {
  const _$BuBuilderTearOff();

  _BuBuilder call({required String description}) {
    return _BuBuilder(
      description: description,
    );
  }

  BuBuilder fromJson(Map<String, Object?> json) {
    return BuBuilder.fromJson(json);
  }
}

/// @nodoc
const $BuBuilder = _$BuBuilderTearOff();

/// @nodoc
mixin _$BuBuilder {
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuBuilderCopyWith<BuBuilder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuBuilderCopyWith<$Res> {
  factory $BuBuilderCopyWith(BuBuilder value, $Res Function(BuBuilder) then) =
      _$BuBuilderCopyWithImpl<$Res>;
  $Res call({String description});
}

/// @nodoc
class _$BuBuilderCopyWithImpl<$Res> implements $BuBuilderCopyWith<$Res> {
  _$BuBuilderCopyWithImpl(this._value, this._then);

  final BuBuilder _value;
  // ignore: unused_field
  final $Res Function(BuBuilder) _then;

  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BuBuilderCopyWith<$Res> implements $BuBuilderCopyWith<$Res> {
  factory _$BuBuilderCopyWith(
          _BuBuilder value, $Res Function(_BuBuilder) then) =
      __$BuBuilderCopyWithImpl<$Res>;
  @override
  $Res call({String description});
}

/// @nodoc
class __$BuBuilderCopyWithImpl<$Res> extends _$BuBuilderCopyWithImpl<$Res>
    implements _$BuBuilderCopyWith<$Res> {
  __$BuBuilderCopyWithImpl(_BuBuilder _value, $Res Function(_BuBuilder) _then)
      : super(_value, (v) => _then(v as _BuBuilder));

  @override
  _BuBuilder get _value => super._value as _BuBuilder;

  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_BuBuilder(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BuBuilder with DiagnosticableTreeMixin implements _BuBuilder {
  const _$_BuBuilder({required this.description});

  factory _$_BuBuilder.fromJson(Map<String, dynamic> json) =>
      _$$_BuBuilderFromJson(json);

  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BuBuilder(description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BuBuilder'))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuBuilder &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$BuBuilderCopyWith<_BuBuilder> get copyWith =>
      __$BuBuilderCopyWithImpl<_BuBuilder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuBuilderToJson(this);
  }
}

abstract class _BuBuilder implements BuBuilder {
  const factory _BuBuilder({required String description}) = _$_BuBuilder;

  factory _BuBuilder.fromJson(Map<String, dynamic> json) =
      _$_BuBuilder.fromJson;

  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$BuBuilderCopyWith<_BuBuilder> get copyWith =>
      throw _privateConstructorUsedError;
}
