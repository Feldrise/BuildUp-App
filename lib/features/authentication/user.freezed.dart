// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required String email,
      required String firstName,
      required String lastName,
      required String role,
      required String step,
      BuBuilder? builder,
      Coach? coach}) {
    return _User(
      email: email,
      firstName: firstName,
      lastName: lastName,
      role: role,
      step: step,
      builder: builder,
      coach: coach,
    );
  }

  User fromJson(Map<String, Object?> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get step => throw _privateConstructorUsedError;
  BuBuilder? get builder => throw _privateConstructorUsedError;
  Coach? get coach => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String role,
      String step,
      BuBuilder? builder,
      Coach? coach});

  $BuBuilderCopyWith<$Res>? get builder;
  $CoachCopyWith<$Res>? get coach;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? role = freezed,
    Object? step = freezed,
    Object? builder = freezed,
    Object? coach = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      step: step == freezed
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as String,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as BuBuilder?,
      coach: coach == freezed
          ? _value.coach
          : coach // ignore: cast_nullable_to_non_nullable
              as Coach?,
    ));
  }

  @override
  $BuBuilderCopyWith<$Res>? get builder {
    if (_value.builder == null) {
      return null;
    }

    return $BuBuilderCopyWith<$Res>(_value.builder!, (value) {
      return _then(_value.copyWith(builder: value));
    });
  }

  @override
  $CoachCopyWith<$Res>? get coach {
    if (_value.coach == null) {
      return null;
    }

    return $CoachCopyWith<$Res>(_value.coach!, (value) {
      return _then(_value.copyWith(coach: value));
    });
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String role,
      String step,
      BuBuilder? builder,
      Coach? coach});

  @override
  $BuBuilderCopyWith<$Res>? get builder;
  @override
  $CoachCopyWith<$Res>? get coach;
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? role = freezed,
    Object? step = freezed,
    Object? builder = freezed,
    Object? coach = freezed,
  }) {
    return _then(_User(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      step: step == freezed
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as String,
      builder: builder == freezed
          ? _value.builder
          : builder // ignore: cast_nullable_to_non_nullable
              as BuBuilder?,
      coach: coach == freezed
          ? _value.coach
          : coach // ignore: cast_nullable_to_non_nullable
              as Coach?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User with DiagnosticableTreeMixin implements _User {
  const _$_User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.step,
      this.builder,
      this.coach});

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String role;
  @override
  final String step;
  @override
  final BuBuilder? builder;
  @override
  final Coach? coach;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'User(email: $email, firstName: $firstName, lastName: $lastName, role: $role, step: $step, builder: $builder, coach: $coach)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'User'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('step', step))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(DiagnosticsProperty('coach', coach));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.role, role) &&
            const DeepCollectionEquality().equals(other.step, step) &&
            const DeepCollectionEquality().equals(other.builder, builder) &&
            const DeepCollectionEquality().equals(other.coach, coach));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(role),
      const DeepCollectionEquality().hash(step),
      const DeepCollectionEquality().hash(builder),
      const DeepCollectionEquality().hash(coach));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(this);
  }
}

abstract class _User implements User {
  const factory _User(
      {required String email,
      required String firstName,
      required String lastName,
      required String role,
      required String step,
      BuBuilder? builder,
      Coach? coach}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get role;
  @override
  String get step;
  @override
  BuBuilder? get builder;
  @override
  Coach? get coach;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
