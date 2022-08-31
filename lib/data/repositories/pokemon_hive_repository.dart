import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';

import 'hive_repository.dart';

class PokemonHiveRepository extends HiveRepository<PokemonModel> {
  PokemonHiveRepository({required GraphQLService graphQLService})
      : _graphQLService = graphQLService;

  final GraphQLService _graphQLService;

  /// Get list of [PokemonModel]
  Future<List<PokemonModel>> fetchPokemons({int offset = 0}) async {
    try {
      final List<PokemonModel> result =
          await _graphQLService.fetchPokemons(offset: offset);

      insertAll(result);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PokemonModel>> search(String text) async {
    final List<PokemonModel> result =
        await where((PokemonModel r) => r.name.contains(text));

    return result;
  }
}
