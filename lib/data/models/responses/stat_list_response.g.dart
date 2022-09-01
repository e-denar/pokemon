// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatListResponse _$StatListResponseFromJson(Map<String, dynamic> json) =>
    StatListResponse(
      (json['pokemon_v2_pokemonstat'] as List<dynamic>)
          .map((e) => StatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatListResponseToJson(StatListResponse instance) =>
    <String, dynamic>{
      'pokemon_v2_pokemonstat': instance.stats,
    };
