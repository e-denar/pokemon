import 'package:flutter/material.dart';
import 'package:pokemon/data/models/pokemon_model.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({
    Key? key,
    required this.pokemonModel,
  }) : super(key: key);

  final PokemonModel pokemonModel;

  @override
  Widget build(BuildContext context) {
    final String title = pokemonModel.name;
    final String imageUrl = pokemonModel.imageUrl;
    final String height = pokemonModel.height.toString();
    final String width = pokemonModel.weight.toString();
    final String baseXp = pokemonModel.baseExperience.toString();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Height: $height',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                'Width: $width',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              Text(
                'Base XP: $baseXp',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.network(
              imageUrl,
              height: 100,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
