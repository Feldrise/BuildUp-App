// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'form_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FormItem _$FormItemFromJson(Map<String, dynamic> json) {
  return _FormItem.fromJson(json);
}

/// @nodoc
class _$FormItemTearOff {
  const _$FormItemTearOff();

  _FormItem call({required String question, required String answer}) {
    return _FormItem(
      question: question,
      answer: answer,
    );
  }

  FormItem fromJson(Map<String, Object?> json) {
    return FormItem.fromJson(json);
  }
}

/// @nodoc
const $FormItem = _$FormItemTearOff();

/// @nodoc
mixin _$FormItem {
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FormItemCopyWith<FormItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FormItemCopyWith<$Res> {
  factory $FormItemCopyWith(FormItem value, $Res Function(FormItem) then) =
      _$FormItemCopyWithImpl<$Res>;
  $Res call({String question, String answer});
}

/// @nodoc
class _$FormItemCopyWithImpl<$Res> implements $FormItemCopyWith<$Res> {
  _$FormItemCopyWithImpl(this._value, this._then);

  final FormItem _value;
  // ignore: unused_field
  final $Res Function(FormItem) _then;

  @override
  $Res call({
    Object? question = freezed,
    Object? answer = freezed,
  }) {
    return _then(_value.copyWith(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: answer == freezed
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$FormItemCopyWith<$Res> implements $FormItemCopyWith<$Res> {
  factory _$FormItemCopyWith(_FormItem value, $Res Function(_FormItem) then) =
      __$FormItemCopyWithImpl<$Res>;
  @override
  $Res call({String question, String answer});
}

/// @nodoc
class __$FormItemCopyWithImpl<$Res> extends _$FormItemCopyWithImpl<$Res>
    implements _$FormItemCopyWith<$Res> {
  __$FormItemCopyWithImpl(_FormItem _value, $Res Function(_FormItem) _then)
      : super(_value, (v) => _then(v as _FormItem));

  @override
  _FormItem get _value => super._value as _FormItem;

  @override
  $Res call({
    Object? question = freezed,
    Object? answer = freezed,
  }) {
    return _then(_FormItem(
      question: question == freezed
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: answer == freezed
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FormItem with DiagnosticableTreeMixin implements _FormItem {
  const _$_FormItem({required this.question, required this.answer});

  factory _$_FormItem.fromJson(Map<String, dynamic> json) =>
      _$$_FormItemFromJson(json);

  @override
  final String question;
  @override
  final String answer;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FormItem(question: $question, answer: $answer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FormItem'))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('answer', answer));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FormItem &&
            const DeepCollectionEquality().equals(other.question, question) &&
            const DeepCollectionEquality().equals(other.answer, answer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(question),
      const DeepCollectionEquality().hash(answer));

  @JsonKey(ignore: true)
  @override
  _$FormItemCopyWith<_FormItem> get copyWith =>
      __$FormItemCopyWithImpl<_FormItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FormItemToJson(this);
  }
}

abstract class _FormItem implements FormItem {
  const factory _FormItem({required String question, required String answer}) =
      _$_FormItem;

  factory _FormItem.fromJson(Map<String, dynamic> json) = _$_FormItem.fromJson;

  @override
  String get question;
  @override
  String get answer;
  @override
  @JsonKey(ignore: true)
  _$FormItemCopyWith<_FormItem> get copyWith =>
      throw _privateConstructorUsedError;
}
