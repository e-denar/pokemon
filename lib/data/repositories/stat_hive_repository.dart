import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/data/models/pokemon_stat_model.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';

import 'hive_repository.dart';

class StatHiveRepository extends HiveRepository<PokemonStatModel> {
  StatHiveRepository({required GraphQLService graphQLService})
      : _graphQLService = graphQLService;

  final GraphQLService _graphQLService;

  /// Get list of [StatModel]
  Future<List<StatModel>> fetchStats(dynamic id) async {
    try {
      final List<StatModel> result =
          await _graphQLService.fetchPokemonStats(id: id);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ValueListenable<Box<PokemonStatModel>>> getListenable(
      {dynamic key}) async {
    final ValueListenable<Box<PokemonStatModel>> listenable =
        await super.getListenable(key: key);

    // Only fetch data from api once
    // To simulate local update since there is no update api
    if (!listenable.value.containsKey(key)) {
      final List<StatModel> stats = await fetchStats(key);
      insert(PokemonStatModel(key as int, stats));
    }

    return listenable;
  }
}
