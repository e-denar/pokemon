import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon/data/models/pokemon_model.dart';

part 'pokemon_list_response.g.dart';

@JsonSerializable()
class PokemonListResponse {
  const PokemonListResponse(this.pokemons);

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);

  @JsonKey(name: 'pokemon_v2_pokemon')
  final List<PokemonModel> pokemons;
}
