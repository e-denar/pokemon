import 'package:pokemon/data/models/models.barrel.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';
import 'package:pokemon/viewmodels/view_model.dart';

class DetailViewModel extends ViewModel {
  DetailViewModel(this.pokemon, this._graphQLService) {
    init();
  }

  final PokemonModel pokemon;
  final GraphQLService _graphQLService;

  void init() {
    try {
      startLoading();
      // TODO: fetch details
      stopLoading();
    } catch (e) {
      startError();
    }
  }
}
