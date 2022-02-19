// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'page_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PageItemTearOff {
  const _$PageItemTearOff();

  _PageItem call(
      {required int index,
      required String title,
      IconData? icon,
      Widget? suffixWidget}) {
    return _PageItem(
      index: index,
      title: title,
      icon: icon,
      suffixWidget: suffixWidget,
    );
  }
}

/// @nodoc
const $PageItem = _$PageItemTearOff();

/// @nodoc
mixin _$PageItem {
  int get index => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;
  Widget? get suffixWidget => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageItemCopyWith<PageItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageItemCopyWith<$Res> {
  factory $PageItemCopyWith(PageItem value, $Res Function(PageItem) then) =
      _$PageItemCopyWithImpl<$Res>;
  $Res call({int index, String title, IconData? icon, Widget? suffixWidget});
}

/// @nodoc
class _$PageItemCopyWithImpl<$Res> implements $PageItemCopyWith<$Res> {
  _$PageItemCopyWithImpl(this._value, this._then);

  final PageItem _value;
  // ignore: unused_field
  final $Res Function(PageItem) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? title = freezed,
    Object? icon = freezed,
    Object? suffixWidget = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      suffixWidget: suffixWidget == freezed
          ? _value.suffixWidget
          : suffixWidget // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }
}

/// @nodoc
abstract class _$PageItemCopyWith<$Res> implements $PageItemCopyWith<$Res> {
  factory _$PageItemCopyWith(_PageItem value, $Res Function(_PageItem) then) =
      __$PageItemCopyWithImpl<$Res>;
  @override
  $Res call({int index, String title, IconData? icon, Widget? suffixWidget});
}

/// @nodoc
class __$PageItemCopyWithImpl<$Res> extends _$PageItemCopyWithImpl<$Res>
    implements _$PageItemCopyWith<$Res> {
  __$PageItemCopyWithImpl(_PageItem _value, $Res Function(_PageItem) _then)
      : super(_value, (v) => _then(v as _PageItem));

  @override
  _PageItem get _value => super._value as _PageItem;

  @override
  $Res call({
    Object? index = freezed,
    Object? title = freezed,
    Object? icon = freezed,
    Object? suffixWidget = freezed,
  }) {
    return _then(_PageItem(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      suffixWidget: suffixWidget == freezed
          ? _value.suffixWidget
          : suffixWidget // ignore: cast_nullable_to_non_nullable
              as Widget?,
    ));
  }
}

/// @nodoc

class _$_PageItem with DiagnosticableTreeMixin implements _PageItem {
  const _$_PageItem(
      {required this.index, required this.title, this.icon, this.suffixWidget});

  @override
  final int index;
  @override
  final String title;
  @override
  final IconData? icon;
  @override
  final Widget? suffixWidget;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PageItem(index: $index, title: $title, icon: $icon, suffixWidget: $suffixWidget)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PageItem'))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('suffixWidget', suffixWidget));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PageItem &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality()
                .equals(other.suffixWidget, suffixWidget));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(suffixWidget));

  @JsonKey(ignore: true)
  @override
  _$PageItemCopyWith<_PageItem> get copyWith =>
      __$PageItemCopyWithImpl<_PageItem>(this, _$identity);
}

abstract class _PageItem implements PageItem {
  const factory _PageItem(
      {required int index,
      required String title,
      IconData? icon,
      Widget? suffixWidget}) = _$_PageItem;

  @override
  int get index;
  @override
  String get title;
  @override
  IconData? get icon;
  @override
  Widget? get suffixWidget;
  @override
  @JsonKey(ignore: true)
  _$PageItemCopyWith<_PageItem> get copyWith =>
      throw _privateConstructorUsedError;
}
