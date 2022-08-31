import 'dart:collection';

import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';
import 'package:pokemon/viewmodels/view_model.dart';

class FeedViewModel extends ViewModel {
  FeedViewModel(
    this._graphQLService,
  ) {
    init();
  }

  final GraphQLService _graphQLService;

  final LinkedHashMap<String, PokemonModel> _cache =
      LinkedHashMap<String, PokemonModel>();

  List<PokemonModel> get items => _cache.values.toList();

  Future<void> init() async {
    try {
      startLoading();
      await fetch();
      stopLoading();
    } catch (e) {
      startError();
    }
  }

  Future<void> fetch() async {
    final List<PokemonModel> result = await _graphQLService.fetchPokemons(
      offset: _cache.length,
    );

    _cache.addAll(<String, PokemonModel>{
      for (final PokemonModel e in result) e.id: e,
    });

    notifyListeners();
  }
}
