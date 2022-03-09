// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'proof.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Proof _$ProofFromJson(Map<String, dynamic> json) {
  return _Proof.fromJson(json);
}

/// @nodoc
class _$ProofTearOff {
  const _$ProofTearOff();

  _Proof call(String? id,
      {required String stepID,
      required String type,
      required String status,
      String? comment}) {
    return _Proof(
      id,
      stepID: stepID,
      type: type,
      status: status,
      comment: comment,
    );
  }

  Proof fromJson(Map<String, Object?> json) {
    return Proof.fromJson(json);
  }
}

/// @nodoc
const $Proof = _$ProofTearOff();

/// @nodoc
mixin _$Proof {
  String? get id => throw _privateConstructorUsedError;
  String get stepID => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProofCopyWith<Proof> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProofCopyWith<$Res> {
  factory $ProofCopyWith(Proof value, $Res Function(Proof) then) =
      _$ProofCopyWithImpl<$Res>;
  $Res call(
      {String? id, String stepID, String type, String status, String? comment});
}

/// @nodoc
class _$ProofCopyWithImpl<$Res> implements $ProofCopyWith<$Res> {
  _$ProofCopyWithImpl(this._value, this._then);

  final Proof _value;
  // ignore: unused_field
  final $Res Function(Proof) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? stepID = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      stepID: stepID == freezed
          ? _value.stepID
          : stepID // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ProofCopyWith<$Res> implements $ProofCopyWith<$Res> {
  factory _$ProofCopyWith(_Proof value, $Res Function(_Proof) then) =
      __$ProofCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id, String stepID, String type, String status, String? comment});
}

/// @nodoc
class __$ProofCopyWithImpl<$Res> extends _$ProofCopyWithImpl<$Res>
    implements _$ProofCopyWith<$Res> {
  __$ProofCopyWithImpl(_Proof _value, $Res Function(_Proof) _then)
      : super(_value, (v) => _then(v as _Proof));

  @override
  _Proof get _value => super._value as _Proof;

  @override
  $Res call({
    Object? id = freezed,
    Object? stepID = freezed,
    Object? type = freezed,
    Object? status = freezed,
    Object? comment = freezed,
  }) {
    return _then(_Proof(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      stepID: stepID == freezed
          ? _value.stepID
          : stepID // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Proof with DiagnosticableTreeMixin implements _Proof {
  const _$_Proof(this.id,
      {required this.stepID,
      required this.type,
      required this.status,
      this.comment});

  factory _$_Proof.fromJson(Map<String, dynamic> json) =>
      _$$_ProofFromJson(json);

  @override
  final String? id;
  @override
  final String stepID;
  @override
  final String type;
  @override
  final String status;
  @override
  final String? comment;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Proof(id: $id, stepID: $stepID, type: $type, status: $status, comment: $comment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Proof'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('stepID', stepID))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('comment', comment));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Proof &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.stepID, stepID) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.comment, comment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(stepID),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(comment));

  @JsonKey(ignore: true)
  @override
  _$ProofCopyWith<_Proof> get copyWith =>
      __$ProofCopyWithImpl<_Proof>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProofToJson(this);
  }
}

abstract class _Proof implements Proof {
  const factory _Proof(String? id,
      {required String stepID,
      required String type,
      required String status,
      String? comment}) = _$_Proof;

  factory _Proof.fromJson(Map<String, dynamic> json) = _$_Proof.fromJson;

  @override
  String? get id;
  @override
  String get stepID;
  @override
  String get type;
  @override
  String get status;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$ProofCopyWith<_Proof> get copyWith => throw _privateConstructorUsedError;
}
