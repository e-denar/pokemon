import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon/common/constants/hive_type_ids.dart';
import 'package:pokemon/data/models/data_object.dart';
import 'package:pokemon/data/models/sprite_model.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypeIds.pokemonTypeId)
class PokemonModel extends DataObject {
  PokemonModel(
    int id,
    this.name,
    this.height,
    this.weight,
    this.baseExperience,
    this.imageUrl,
  ) : super(id: id);

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return _$PokemonModelFromJson(json);
  }

  @HiveField(1)
  String name;

  @HiveField(2)
  int height;

  @HiveField(3)
  int weight;

  @JsonKey(name: 'base_experience')
  @HiveField(4)
  int baseExperience;

  @JsonKey(name: 'pokemon_v2_pokemonsprites', fromJson: _imageUrlDecoder)
  @HiveField(5)
  String imageUrl;

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}

String _imageUrlDecoder(List<dynamic> list) {
  final Sprite result = Sprite.fromJson(list.first as Map<String, dynamic>);

  return result.sprites.imageUrl;
}
