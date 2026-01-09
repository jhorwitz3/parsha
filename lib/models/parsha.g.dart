// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParshaImpl _$$ParshaImplFromJson(Map<String, dynamic> json) => _$ParshaImpl(
      name: json['name'] as String,
      summary: StringUrlNameTriplet.fromJson(
          json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ParshaImplToJson(_$ParshaImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'summary': instance.summary,
    };

_$CharacterImpl _$$CharacterImplFromJson(Map<String, dynamic> json) =>
    _$CharacterImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      keyActions: (json['keyActions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CharacterImplToJson(_$CharacterImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'keyActions': instance.keyActions,
    };
