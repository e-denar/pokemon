import 'package:dio/dio.dart';
import 'package:pokemon/common/utils/extensions.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/models/responses/pokemon_list_response.dart';
import 'package:pokemon/env.dart';

class GraphQLService {
  GraphQLService({Dio? dio})
      : _dio = dio ?? Dio()
          ..options = BaseOptions(baseUrl: ENV_.baseUrl);

  final Dio? _dio;

  /// Get list of [PokemonModel]
  Future<List<PokemonModel>> fetchPokemons() async {
    try {
      final PokemonListResponse? result =
          await _dio?.graphQLRequest<PokemonListResponse>(
        document: '''
        {
          pokemon_v2_pokemon(limit: 5, offset: 10) {
            pokemon_species_id
            order
            name
            is_default
            id
            height
            base_experience
            weight
            pokemon_v2_pokemonsprites {
              sprites
            }
          }
        }
        ''',
        decoder: (Map<String, dynamic> json) =>
            PokemonListResponse.fromJson(json),
      );

      return result!.pokemons;
    } catch (e) {
      rethrow;
    }
  }
}
