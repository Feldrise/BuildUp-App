// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppUserStateTearOff {
  const _$AppUserStateTearOff();

  _AppUserState call({String? token}) {
    return _AppUserState(
      token: token,
    );
  }
}

/// @nodoc
const $AppUserState = _$AppUserStateTearOff();

/// @nodoc
mixin _$AppUserState {
  String? get token => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppUserStateCopyWith<AppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserStateCopyWith<$Res> {
  factory $AppUserStateCopyWith(
          AppUserState value, $Res Function(AppUserState) then) =
      _$AppUserStateCopyWithImpl<$Res>;
  $Res call({String? token});
}

/// @nodoc
class _$AppUserStateCopyWithImpl<$Res> implements $AppUserStateCopyWith<$Res> {
  _$AppUserStateCopyWithImpl(this._value, this._then);

  final AppUserState _value;
  // ignore: unused_field
  final $Res Function(AppUserState) _then;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$AppUserStateCopyWith<$Res>
    implements $AppUserStateCopyWith<$Res> {
  factory _$AppUserStateCopyWith(
          _AppUserState value, $Res Function(_AppUserState) then) =
      __$AppUserStateCopyWithImpl<$Res>;
  @override
  $Res call({String? token});
}

/// @nodoc
class __$AppUserStateCopyWithImpl<$Res> extends _$AppUserStateCopyWithImpl<$Res>
    implements _$AppUserStateCopyWith<$Res> {
  __$AppUserStateCopyWithImpl(
      _AppUserState _value, $Res Function(_AppUserState) _then)
      : super(_value, (v) => _then(v as _AppUserState));

  @override
  _AppUserState get _value => super._value as _AppUserState;

  @override
  $Res call({
    Object? token = freezed,
  }) {
    return _then(_AppUserState(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AppUserState with DiagnosticableTreeMixin implements _AppUserState {
  const _$_AppUserState({this.token});

  @override
  final String? token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUserState(token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUserState'))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUserState &&
            const DeepCollectionEquality().equals(other.token, token));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(token));

  @JsonKey(ignore: true)
  @override
  _$AppUserStateCopyWith<_AppUserState> get copyWith =>
      __$AppUserStateCopyWithImpl<_AppUserState>(this, _$identity);
}

abstract class _AppUserState implements AppUserState {
  const factory _AppUserState({String? token}) = _$_AppUserState;

  @override
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$AppUserStateCopyWith<_AppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}
