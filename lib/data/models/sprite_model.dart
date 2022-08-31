import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'sprite_model.g.dart';

@JsonSerializable()
class Sprite {
  Sprite(this.sprites);

  factory Sprite.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> decodedJson = <String, dynamic>{
      'sprites': jsonDecode(json['sprites'] as String)
    };
    return _$SpriteFromJson(decodedJson);
  }
  Map<String, dynamic> toJson() => _$SpriteToJson(this);

  final SpriteData sprites;
}

@JsonSerializable()
class SpriteData {
  SpriteData(this.imageUrl);

  factory SpriteData.fromJson(Map<String, dynamic> json) =>
      _$SpriteDataFromJson(json);

  Map<String, dynamic> toJson() => _$SpriteDataToJson(this);

  @JsonKey(name: 'front_default')
  final String imageUrl;
}
