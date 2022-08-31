// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sprite _$SpriteFromJson(Map<String, dynamic> json) => Sprite(
      SpriteData.fromJson(json['sprites'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpriteToJson(Sprite instance) => <String, dynamic>{
      'sprites': instance.sprites,
    };

SpriteData _$SpriteDataFromJson(Map<String, dynamic> json) => SpriteData(
      json['front_default'] as String,
    );

Map<String, dynamic> _$SpriteDataToJson(SpriteData instance) =>
    <String, dynamic>{
      'front_default': instance.imageUrl,
    };
