import 'package:pokemon/data/models/models.barrel.dart';
import 'package:pokemon/data/repositories/pokemon_hive_repository.dart';
import 'package:pokemon/viewmodels/view_model.dart';

class DetailViewModel extends ViewModel {
  DetailViewModel(this.pokemon, this._repository);

  final PokemonModel pokemon;
  final PokemonHiveRepository _repository;

  void delete() {
    _repository.delete(pokemon.id);
  }
}
