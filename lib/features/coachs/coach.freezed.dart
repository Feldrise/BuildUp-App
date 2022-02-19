// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'coach.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Coach _$CoachFromJson(Map<String, dynamic> json) {
  return _Coach.fromJson(json);
}

/// @nodoc
class _$CoachTearOff {
  const _$CoachTearOff();

  _Coach call(
      {required String description,
      String situation = "Situation Inconnue",
      List<User>? builders}) {
    return _Coach(
      description: description,
      situation: situation,
      builders: builders,
    );
  }

  Coach fromJson(Map<String, Object?> json) {
    return Coach.fromJson(json);
  }
}

/// @nodoc
const $Coach = _$CoachTearOff();

/// @nodoc
mixin _$Coach {
  String get description => throw _privateConstructorUsedError;
  String get situation => throw _privateConstructorUsedError;
  List<User>? get builders => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoachCopyWith<Coach> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoachCopyWith<$Res> {
  factory $CoachCopyWith(Coach value, $Res Function(Coach) then) =
      _$CoachCopyWithImpl<$Res>;
  $Res call({String description, String situation, List<User>? builders});
}

/// @nodoc
class _$CoachCopyWithImpl<$Res> implements $CoachCopyWith<$Res> {
  _$CoachCopyWithImpl(this._value, this._then);

  final Coach _value;
  // ignore: unused_field
  final $Res Function(Coach) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? situation = freezed,
    Object? builders = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      situation: situation == freezed
          ? _value.situation
          : situation // ignore: cast_nullable_to_non_nullable
              as String,
      builders: builders == freezed
          ? _value.builders
          : builders // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ));
  }
}

/// @nodoc
abstract class _$CoachCopyWith<$Res> implements $CoachCopyWith<$Res> {
  factory _$CoachCopyWith(_Coach value, $Res Function(_Coach) then) =
      __$CoachCopyWithImpl<$Res>;
  @override
  $Res call({String description, String situation, List<User>? builders});
}

/// @nodoc
class __$CoachCopyWithImpl<$Res> extends _$CoachCopyWithImpl<$Res>
    implements _$CoachCopyWith<$Res> {
  __$CoachCopyWithImpl(_Coach _value, $Res Function(_Coach) _then)
      : super(_value, (v) => _then(v as _Coach));

  @override
  _Coach get _value => super._value as _Coach;

  @override
  $Res call({
    Object? description = freezed,
    Object? situation = freezed,
    Object? builders = freezed,
  }) {
    return _then(_Coach(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      situation: situation == freezed
          ? _value.situation
          : situation // ignore: cast_nullable_to_non_nullable
              as String,
      builders: builders == freezed
          ? _value.builders
          : builders // ignore: cast_nullable_to_non_nullable
              as List<User>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Coach with DiagnosticableTreeMixin implements _Coach {
  const _$_Coach(
      {required this.description,
      this.situation = "Situation Inconnue",
      this.builders});

  factory _$_Coach.fromJson(Map<String, dynamic> json) =>
      _$$_CoachFromJson(json);

  @override
  final String description;
  @JsonKey()
  @override
  final String situation;
  @override
  final List<User>? builders;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Coach(description: $description, situation: $situation, builders: $builders)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Coach'))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('situation', situation))
      ..add(DiagnosticsProperty('builders', builders));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Coach &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.situation, situation) &&
            const DeepCollectionEquality().equals(other.builders, builders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(situation),
      const DeepCollectionEquality().hash(builders));

  @JsonKey(ignore: true)
  @override
  _$CoachCopyWith<_Coach> get copyWith =>
      __$CoachCopyWithImpl<_Coach>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CoachToJson(this);
  }
}

abstract class _Coach implements Coach {
  const factory _Coach(
      {required String description,
      String situation,
      List<User>? builders}) = _$_Coach;

  factory _Coach.fromJson(Map<String, dynamic> json) = _$_Coach.fromJson;

  @override
  String get description;
  @override
  String get situation;
  @override
  List<User>? get builders;
  @override
  @JsonKey(ignore: true)
  _$CoachCopyWith<_Coach> get copyWith => throw _privateConstructorUsedError;
}
