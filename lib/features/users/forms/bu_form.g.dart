// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bu_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BuForm _$$_BuFormFromJson(Map<String, dynamic> json) => _$_BuForm(
      json['id'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => FormItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FormItem>[],
    );

Map<String, dynamic> _$$_BuFormToJson(_$_BuForm instance) => <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
    };
