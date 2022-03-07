// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'buildon_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BuildOnStep _$BuildOnStepFromJson(Map<String, dynamic> json) {
  return _BuildOnStep.fromJson(json);
}

/// @nodoc
class _$BuildOnStepTearOff {
  const _$BuildOnStepTearOff();

  _BuildOnStep call(String? id,
      {required String name,
      required int index,
      String description = "Pas de description fournis",
      String proofType = "Pas d'information",
      String proofDescription = "Pas d'information"}) {
    return _BuildOnStep(
      id,
      name: name,
      index: index,
      description: description,
      proofType: proofType,
      proofDescription: proofDescription,
    );
  }

  BuildOnStep fromJson(Map<String, Object?> json) {
    return BuildOnStep.fromJson(json);
  }
}

/// @nodoc
const $BuildOnStep = _$BuildOnStepTearOff();

/// @nodoc
mixin _$BuildOnStep {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get proofType => throw _privateConstructorUsedError;
  String get proofDescription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuildOnStepCopyWith<BuildOnStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildOnStepCopyWith<$Res> {
  factory $BuildOnStepCopyWith(
          BuildOnStep value, $Res Function(BuildOnStep) then) =
      _$BuildOnStepCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      int index,
      String description,
      String proofType,
      String proofDescription});
}

/// @nodoc
class _$BuildOnStepCopyWithImpl<$Res> implements $BuildOnStepCopyWith<$Res> {
  _$BuildOnStepCopyWithImpl(this._value, this._then);

  final BuildOnStep _value;
  // ignore: unused_field
  final $Res Function(BuildOnStep) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? index = freezed,
    Object? description = freezed,
    Object? proofType = freezed,
    Object? proofDescription = freezed,
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
      proofType: proofType == freezed
          ? _value.proofType
          : proofType // ignore: cast_nullable_to_non_nullable
              as String,
      proofDescription: proofDescription == freezed
          ? _value.proofDescription
          : proofDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BuildOnStepCopyWith<$Res>
    implements $BuildOnStepCopyWith<$Res> {
  factory _$BuildOnStepCopyWith(
          _BuildOnStep value, $Res Function(_BuildOnStep) then) =
      __$BuildOnStepCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      int index,
      String description,
      String proofType,
      String proofDescription});
}

/// @nodoc
class __$BuildOnStepCopyWithImpl<$Res> extends _$BuildOnStepCopyWithImpl<$Res>
    implements _$BuildOnStepCopyWith<$Res> {
  __$BuildOnStepCopyWithImpl(
      _BuildOnStep _value, $Res Function(_BuildOnStep) _then)
      : super(_value, (v) => _then(v as _BuildOnStep));

  @override
  _BuildOnStep get _value => super._value as _BuildOnStep;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? index = freezed,
    Object? description = freezed,
    Object? proofType = freezed,
    Object? proofDescription = freezed,
  }) {
    return _then(_BuildOnStep(
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
      proofType: proofType == freezed
          ? _value.proofType
          : proofType // ignore: cast_nullable_to_non_nullable
              as String,
      proofDescription: proofDescription == freezed
          ? _value.proofDescription
          : proofDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BuildOnStep with DiagnosticableTreeMixin implements _BuildOnStep {
  const _$_BuildOnStep(this.id,
      {required this.name,
      required this.index,
      this.description = "Pas de description fournis",
      this.proofType = "Pas d'information",
      this.proofDescription = "Pas d'information"});

  factory _$_BuildOnStep.fromJson(Map<String, dynamic> json) =>
      _$$_BuildOnStepFromJson(json);

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
  final String proofType;
  @JsonKey()
  @override
  final String proofDescription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BuildOnStep(id: $id, name: $name, index: $index, description: $description, proofType: $proofType, proofDescription: $proofDescription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BuildOnStep'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('proofType', proofType))
      ..add(DiagnosticsProperty('proofDescription', proofDescription));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuildOnStep &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.proofType, proofType) &&
            const DeepCollectionEquality()
                .equals(other.proofDescription, proofDescription));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(proofType),
      const DeepCollectionEquality().hash(proofDescription));

  @JsonKey(ignore: true)
  @override
  _$BuildOnStepCopyWith<_BuildOnStep> get copyWith =>
      __$BuildOnStepCopyWithImpl<_BuildOnStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuildOnStepToJson(this);
  }
}

abstract class _BuildOnStep implements BuildOnStep {
  const factory _BuildOnStep(String? id,
      {required String name,
      required int index,
      String description,
      String proofType,
      String proofDescription}) = _$_BuildOnStep;

  factory _BuildOnStep.fromJson(Map<String, dynamic> json) =
      _$_BuildOnStep.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  int get index;
  @override
  String get description;
  @override
  String get proofType;
  @override
  String get proofDescription;
  @override
  @JsonKey(ignore: true)
  _$BuildOnStepCopyWith<_BuildOnStep> get copyWith =>
      throw _privateConstructorUsedError;
}
