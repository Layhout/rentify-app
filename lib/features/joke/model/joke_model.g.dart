// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JokeModel _$JokeModelFromJson(Map<String, dynamic> json) => _JokeModel(
  id: (json['id'] as num?)?.toInt(),
  type: json['type'] as String?,
  setup: json['setup'] as String?,
  punchline: json['punchline'] as String?,
);

Map<String, dynamic> _$JokeModelToJson(_JokeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'setup': instance.setup,
      'punchline': instance.punchline,
    };
