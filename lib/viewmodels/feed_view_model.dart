import 'dart:collection';

import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/repositories/pokemon_hive_repository.dart';
import 'package:pokemon/viewmodels/view_model.dart';

class FeedViewModel extends ViewModel {
  FeedViewModel(
    this._repository,
  ) {
    init();
  }

  final PokemonHiveRepository _repository;

  final LinkedHashMap<int, PokemonModel> _cache =
      LinkedHashMap<int, PokemonModel>();

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
    final List<PokemonModel> result = await _repository.fetchPokemons(
      offset: _cache.length,
    );

    _cache.addAll(<int, PokemonModel>{
      for (final PokemonModel e in result) e.id: e,
    });

    notifyListeners();
  }
}
