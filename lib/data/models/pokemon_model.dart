import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon/common/constants/hive_type_ids.dart';
import 'package:pokemon/data/models/data_object.dart';
import 'package:pokemon/data/models/sprite_model.dart';

part 'pokemon_model.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: HiveTypeIds.pokemonTypeId)
class PokemonModel extends DataObject {
  PokemonModel(
    int id,
    this.name,
    this.height,
    this.weight,
    this.baseExperience,
    this.sprites,
  ) : super(id: id.toString());

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int height;

  @HiveField(3)
  final int weight;

  @JsonKey(name: 'base_experience')
  @HiveField(4)
  final int baseExperience;

  @JsonKey(name: 'pokemon_v2_pokemonsprites')
  @HiveField(5)
  final List<Sprite> sprites;

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}
