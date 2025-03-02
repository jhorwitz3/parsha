// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParshaImpl _$$ParshaImplFromJson(Map<String, dynamic> json) => _$ParshaImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ParshaImplToJson(_$ParshaImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'characters': instance.characters,
    };
