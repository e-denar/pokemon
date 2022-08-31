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
  Future<List<PokemonModel>> fetchPokemons({int offset = 0}) async {
    try {
      final PokemonListResponse? result =
          await _dio?.graphQLRequest<PokemonListResponse>(
        document: '''
        query pokemonList(${r'$limit'}: Int!, ${r'$offset'}: Int!) {
          pokemon_v2_pokemon(limit: ${r'$limit'}, offset: ${r'$offset'}) {
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
        variables: <String, dynamic>{
          'limit': ENV_.load,
          'offset': offset,
        },
        decoder: (Map<String, dynamic> json) =>
            PokemonListResponse.fromJson(json),
      );

      return result!.pokemons;
    } catch (e) {
      rethrow;
    }
  }
}
