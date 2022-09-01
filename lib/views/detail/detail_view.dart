import 'package:flutter/material.dart';
import 'package:pokemon/viewmodels/detail_view_model.dart';
import 'package:pokemon/views/detail/widgets/pokemon_details.dart';
import 'package:pokemon/views/detail/widgets/stats_view.dart';
import 'package:pokemon/views/widgets/delete_dialog_box.dart';
import 'package:provider/provider.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailViewModel viewModel = context.read<DetailViewModel>();

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          'Pokemon',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDeleteDialogBox(context, onDelete: () {
                viewModel.pokemon.delete();
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          PokemonDetails(
            pokemonModel: viewModel.pokemon,
          ),
          StatsView(pokemon: viewModel.pokemon),
        ],
      ),
    );
  }
}
