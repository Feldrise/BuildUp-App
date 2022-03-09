// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return _Project.fromJson(json);
}

/// @nodoc
class _$ProjectTearOff {
  const _$ProjectTearOff();

  _Project call(String? id,
      {required String name,
      required String description,
      String? keywords,
      String? categorie,
      String? team,
      DateTime? launchDate,
      bool? isLucarative,
      bool? isOfficialyRegistered,
      List<Proof>? proofs}) {
    return _Project(
      id,
      name: name,
      description: description,
      keywords: keywords,
      categorie: categorie,
      team: team,
      launchDate: launchDate,
      isLucarative: isLucarative,
      isOfficialyRegistered: isOfficialyRegistered,
      proofs: proofs,
    );
  }

  Project fromJson(Map<String, Object?> json) {
    return Project.fromJson(json);
  }
}

/// @nodoc
const $Project = _$ProjectTearOff();

/// @nodoc
mixin _$Project {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get keywords => throw _privateConstructorUsedError;
  String? get categorie => throw _privateConstructorUsedError;
  String? get team => throw _privateConstructorUsedError;
  DateTime? get launchDate => throw _privateConstructorUsedError;
  bool? get isLucarative => throw _privateConstructorUsedError;
  bool? get isOfficialyRegistered => throw _privateConstructorUsedError;
  List<Proof>? get proofs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectCopyWith<Project> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectCopyWith<$Res> {
  factory $ProjectCopyWith(Project value, $Res Function(Project) then) =
      _$ProjectCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      String description,
      String? keywords,
      String? categorie,
      String? team,
      DateTime? launchDate,
      bool? isLucarative,
      bool? isOfficialyRegistered,
      List<Proof>? proofs});
}

/// @nodoc
class _$ProjectCopyWithImpl<$Res> implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._value, this._then);

  final Project _value;
  // ignore: unused_field
  final $Res Function(Project) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? keywords = freezed,
    Object? categorie = freezed,
    Object? team = freezed,
    Object? launchDate = freezed,
    Object? isLucarative = freezed,
    Object? isOfficialyRegistered = freezed,
    Object? proofs = freezed,
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
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as String?,
      categorie: categorie == freezed
          ? _value.categorie
          : categorie // ignore: cast_nullable_to_non_nullable
              as String?,
      team: team == freezed
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      launchDate: launchDate == freezed
          ? _value.launchDate
          : launchDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLucarative: isLucarative == freezed
          ? _value.isLucarative
          : isLucarative // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOfficialyRegistered: isOfficialyRegistered == freezed
          ? _value.isOfficialyRegistered
          : isOfficialyRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      proofs: proofs == freezed
          ? _value.proofs
          : proofs // ignore: cast_nullable_to_non_nullable
              as List<Proof>?,
    ));
  }
}

/// @nodoc
abstract class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) then) =
      __$ProjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      String description,
      String? keywords,
      String? categorie,
      String? team,
      DateTime? launchDate,
      bool? isLucarative,
      bool? isOfficialyRegistered,
      List<Proof>? proofs});
}

/// @nodoc
class __$ProjectCopyWithImpl<$Res> extends _$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(_Project _value, $Res Function(_Project) _then)
      : super(_value, (v) => _then(v as _Project));

  @override
  _Project get _value => super._value as _Project;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? keywords = freezed,
    Object? categorie = freezed,
    Object? team = freezed,
    Object? launchDate = freezed,
    Object? isLucarative = freezed,
    Object? isOfficialyRegistered = freezed,
    Object? proofs = freezed,
  }) {
    return _then(_Project(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as String?,
      categorie: categorie == freezed
          ? _value.categorie
          : categorie // ignore: cast_nullable_to_non_nullable
              as String?,
      team: team == freezed
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      launchDate: launchDate == freezed
          ? _value.launchDate
          : launchDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isLucarative: isLucarative == freezed
          ? _value.isLucarative
          : isLucarative // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOfficialyRegistered: isOfficialyRegistered == freezed
          ? _value.isOfficialyRegistered
          : isOfficialyRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      proofs: proofs == freezed
          ? _value.proofs
          : proofs // ignore: cast_nullable_to_non_nullable
              as List<Proof>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Project with DiagnosticableTreeMixin implements _Project {
  const _$_Project(this.id,
      {required this.name,
      required this.description,
      this.keywords,
      this.categorie,
      this.team,
      this.launchDate,
      this.isLucarative,
      this.isOfficialyRegistered,
      this.proofs});

  factory _$_Project.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? keywords;
  @override
  final String? categorie;
  @override
  final String? team;
  @override
  final DateTime? launchDate;
  @override
  final bool? isLucarative;
  @override
  final bool? isOfficialyRegistered;
  @override
  final List<Proof>? proofs;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Project(id: $id, name: $name, description: $description, keywords: $keywords, categorie: $categorie, team: $team, launchDate: $launchDate, isLucarative: $isLucarative, isOfficialyRegistered: $isOfficialyRegistered, proofs: $proofs)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Project'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('keywords', keywords))
      ..add(DiagnosticsProperty('categorie', categorie))
      ..add(DiagnosticsProperty('team', team))
      ..add(DiagnosticsProperty('launchDate', launchDate))
      ..add(DiagnosticsProperty('isLucarative', isLucarative))
      ..add(DiagnosticsProperty('isOfficialyRegistered', isOfficialyRegistered))
      ..add(DiagnosticsProperty('proofs', proofs));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Project &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.keywords, keywords) &&
            const DeepCollectionEquality().equals(other.categorie, categorie) &&
            const DeepCollectionEquality().equals(other.team, team) &&
            const DeepCollectionEquality()
                .equals(other.launchDate, launchDate) &&
            const DeepCollectionEquality()
                .equals(other.isLucarative, isLucarative) &&
            const DeepCollectionEquality()
                .equals(other.isOfficialyRegistered, isOfficialyRegistered) &&
            const DeepCollectionEquality().equals(other.proofs, proofs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(keywords),
      const DeepCollectionEquality().hash(categorie),
      const DeepCollectionEquality().hash(team),
      const DeepCollectionEquality().hash(launchDate),
      const DeepCollectionEquality().hash(isLucarative),
      const DeepCollectionEquality().hash(isOfficialyRegistered),
      const DeepCollectionEquality().hash(proofs));

  @JsonKey(ignore: true)
  @override
  _$ProjectCopyWith<_Project> get copyWith =>
      __$ProjectCopyWithImpl<_Project>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectToJson(this);
  }
}

abstract class _Project implements Project {
  const factory _Project(String? id,
      {required String name,
      required String description,
      String? keywords,
      String? categorie,
      String? team,
      DateTime? launchDate,
      bool? isLucarative,
      bool? isOfficialyRegistered,
      List<Proof>? proofs}) = _$_Project;

  factory _Project.fromJson(Map<String, dynamic> json) = _$_Project.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get keywords;
  @override
  String? get categorie;
  @override
  String? get team;
  @override
  DateTime? get launchDate;
  @override
  bool? get isLucarative;
  @override
  bool? get isOfficialyRegistered;
  @override
  List<Proof>? get proofs;
  @override
  @JsonKey(ignore: true)
  _$ProjectCopyWith<_Project> get copyWith =>
      throw _privateConstructorUsedError;
}
