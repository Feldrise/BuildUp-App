// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'buildon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BuildOn _$BuildOnFromJson(Map<String, dynamic> json) {
  return _BuildOn.fromJson(json);
}

/// @nodoc
class _$BuildOnTearOff {
  const _$BuildOnTearOff();

  _BuildOn call(String? id,
      {required String name,
      required int index,
      String description = "Pas de description fournis",
      String annexeUrl = "Pas d'URL",
      String rewards = "Pas d'information",
      List<BuildOnStep> steps = const <BuildOnStep>[],
      @JsonKey(ignore: true) BuFile? image}) {
    return _BuildOn(
      id,
      name: name,
      index: index,
      description: description,
      annexeUrl: annexeUrl,
      rewards: rewards,
      steps: steps,
      image: image,
    );
  }

  BuildOn fromJson(Map<String, Object?> json) {
    return BuildOn.fromJson(json);
  }
}

/// @nodoc
const $BuildOn = _$BuildOnTearOff();

/// @nodoc
mixin _$BuildOn {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get annexeUrl => throw _privateConstructorUsedError;
  String get rewards => throw _privateConstructorUsedError;
  List<BuildOnStep> get steps => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  BuFile? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuildOnCopyWith<BuildOn> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildOnCopyWith<$Res> {
  factory $BuildOnCopyWith(BuildOn value, $Res Function(BuildOn) then) =
      _$BuildOnCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      int index,
      String description,
      String annexeUrl,
      String rewards,
      List<BuildOnStep> steps,
      @JsonKey(ignore: true) BuFile? image});

  $BuFileCopyWith<$Res>? get image;
}

/// @nodoc
class _$BuildOnCopyWithImpl<$Res> implements $BuildOnCopyWith<$Res> {
  _$BuildOnCopyWithImpl(this._value, this._then);

  final BuildOn _value;
  // ignore: unused_field
  final $Res Function(BuildOn) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? index = freezed,
    Object? description = freezed,
    Object? annexeUrl = freezed,
    Object? rewards = freezed,
    Object? steps = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      annexeUrl: annexeUrl == freezed
          ? _value.annexeUrl
          : annexeUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rewards: rewards == freezed
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as String,
      steps: steps == freezed
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<BuildOnStep>,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as BuFile?,
    ));
  }

  @override
  $BuFileCopyWith<$Res>? get image {
    if (_value.image == null) {
      return null;
    }

    return $BuFileCopyWith<$Res>(_value.image!, (value) {
      return _then(_value.copyWith(image: value));
    });
  }
}

/// @nodoc
abstract class _$BuildOnCopyWith<$Res> implements $BuildOnCopyWith<$Res> {
  factory _$BuildOnCopyWith(_BuildOn value, $Res Function(_BuildOn) then) =
      __$BuildOnCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      int index,
      String description,
      String annexeUrl,
      String rewards,
      List<BuildOnStep> steps,
      @JsonKey(ignore: true) BuFile? image});

  @override
  $BuFileCopyWith<$Res>? get image;
}

/// @nodoc
class __$BuildOnCopyWithImpl<$Res> extends _$BuildOnCopyWithImpl<$Res>
    implements _$BuildOnCopyWith<$Res> {
  __$BuildOnCopyWithImpl(_BuildOn _value, $Res Function(_BuildOn) _then)
      : super(_value, (v) => _then(v as _BuildOn));

  @override
  _BuildOn get _value => super._value as _BuildOn;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? index = freezed,
    Object? description = freezed,
    Object? annexeUrl = freezed,
    Object? rewards = freezed,
    Object? steps = freezed,
    Object? image = freezed,
  }) {
    return _then(_BuildOn(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      annexeUrl: annexeUrl == freezed
          ? _value.annexeUrl
          : annexeUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rewards: rewards == freezed
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as String,
      steps: steps == freezed
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<BuildOnStep>,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as BuFile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BuildOn with DiagnosticableTreeMixin implements _BuildOn {
  const _$_BuildOn(this.id,
      {required this.name,
      required this.index,
      this.description = "Pas de description fournis",
      this.annexeUrl = "Pas d'URL",
      this.rewards = "Pas d'information",
      this.steps = const <BuildOnStep>[],
      @JsonKey(ignore: true) this.image});

  factory _$_BuildOn.fromJson(Map<String, dynamic> json) =>
      _$$_BuildOnFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final int index;
  @JsonKey()
  @override
  final String description;
  @JsonKey()
  @override
  final String annexeUrl;
  @JsonKey()
  @override
  final String rewards;
  @JsonKey()
  @override
  final List<BuildOnStep> steps;
  @override
  @JsonKey(ignore: true)
  final BuFile? image;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BuildOn(id: $id, name: $name, index: $index, description: $description, annexeUrl: $annexeUrl, rewards: $rewards, steps: $steps, image: $image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BuildOn'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('annexeUrl', annexeUrl))
      ..add(DiagnosticsProperty('rewards', rewards))
      ..add(DiagnosticsProperty('steps', steps))
      ..add(DiagnosticsProperty('image', image));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuildOn &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.annexeUrl, annexeUrl) &&
            const DeepCollectionEquality().equals(other.rewards, rewards) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(annexeUrl),
      const DeepCollectionEquality().hash(rewards),
      const DeepCollectionEquality().hash(steps),
      const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  _$BuildOnCopyWith<_BuildOn> get copyWith =>
      __$BuildOnCopyWithImpl<_BuildOn>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuildOnToJson(this);
  }
}

abstract class _BuildOn implements BuildOn {
  const factory _BuildOn(String? id,
      {required String name,
      required int index,
      String description,
      String annexeUrl,
      String rewards,
      List<BuildOnStep> steps,
      @JsonKey(ignore: true) BuFile? image}) = _$_BuildOn;

  factory _BuildOn.fromJson(Map<String, dynamic> json) = _$_BuildOn.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  int get index;
  @override
  String get description;
  @override
  String get annexeUrl;
  @override
  String get rewards;
  @override
  List<BuildOnStep> get steps;
  @override
  @JsonKey(ignore: true)
  BuFile? get image;
  @override
  @JsonKey(ignore: true)
  _$BuildOnCopyWith<_BuildOn> get copyWith =>
      throw _privateConstructorUsedError;
}
