// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bu_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BuForm _$BuFormFromJson(Map<String, dynamic> json) {
  return _BuForm.fromJson(json);
}

/// @nodoc
class _$BuFormTearOff {
  const _$BuFormTearOff();

  _BuForm call(String? id, {List<FormItem> items = const <FormItem>[]}) {
    return _BuForm(
      id,
      items: items,
    );
  }

  BuForm fromJson(Map<String, Object?> json) {
    return BuForm.fromJson(json);
  }
}

/// @nodoc
const $BuForm = _$BuFormTearOff();

/// @nodoc
mixin _$BuForm {
  String? get id => throw _privateConstructorUsedError;
  List<FormItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuFormCopyWith<BuForm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuFormCopyWith<$Res> {
  factory $BuFormCopyWith(BuForm value, $Res Function(BuForm) then) =
      _$BuFormCopyWithImpl<$Res>;
  $Res call({String? id, List<FormItem> items});
}

/// @nodoc
class _$BuFormCopyWithImpl<$Res> implements $BuFormCopyWith<$Res> {
  _$BuFormCopyWithImpl(this._value, this._then);

  final BuForm _value;
  // ignore: unused_field
  final $Res Function(BuForm) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<FormItem>,
    ));
  }
}

/// @nodoc
abstract class _$BuFormCopyWith<$Res> implements $BuFormCopyWith<$Res> {
  factory _$BuFormCopyWith(_BuForm value, $Res Function(_BuForm) then) =
      __$BuFormCopyWithImpl<$Res>;
  @override
  $Res call({String? id, List<FormItem> items});
}

/// @nodoc
class __$BuFormCopyWithImpl<$Res> extends _$BuFormCopyWithImpl<$Res>
    implements _$BuFormCopyWith<$Res> {
  __$BuFormCopyWithImpl(_BuForm _value, $Res Function(_BuForm) _then)
      : super(_value, (v) => _then(v as _BuForm));

  @override
  _BuForm get _value => super._value as _BuForm;

  @override
  $Res call({
    Object? id = freezed,
    Object? items = freezed,
  }) {
    return _then(_BuForm(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<FormItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BuForm with DiagnosticableTreeMixin implements _BuForm {
  const _$_BuForm(this.id, {this.items = const <FormItem>[]});

  factory _$_BuForm.fromJson(Map<String, dynamic> json) =>
      _$$_BuFormFromJson(json);

  @override
  final String? id;
  @JsonKey()
  @override
  final List<FormItem> items;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BuForm(id: $id, items: $items)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BuForm'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('items', items));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BuForm &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  _$BuFormCopyWith<_BuForm> get copyWith =>
      __$BuFormCopyWithImpl<_BuForm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BuFormToJson(this);
  }
}

abstract class _BuForm implements BuForm {
  const factory _BuForm(String? id, {List<FormItem> items}) = _$_BuForm;

  factory _BuForm.fromJson(Map<String, dynamic> json) = _$_BuForm.fromJson;

  @override
  String? get id;
  @override
  List<FormItem> get items;
  @override
  @JsonKey(ignore: true)
  _$BuFormCopyWith<_BuForm> get copyWith => throw _privateConstructorUsedError;
}
