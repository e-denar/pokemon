import 'package:flutter/material.dart';
import 'package:pokemon/views/widgets/cached_view.dart';
import 'package:pokemon/views/widgets/edit_dialog_box.dart';

import '../../../data/models/models.barrel.dart';

class StatsView extends StatelessWidget {
  const StatsView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return CachedView<PokemonStatModel>(
        id: pokemon.id,
        builder: (BuildContext context, PokemonStatModel model) {
          return Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: model.stats
                  .map((StatModel e) => Row(
                        children: <Widget>[
                          Text(
                            '${e.name} : ${e.baseStat}',
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showEditDialogBox(
                                context,
                                title: e.name,
                                value: e.baseStat.toString(),
                                onSave: (String value) {
                                  model.stats
                                      .firstWhere((StatModel element) =>
                                          element.name == e.name)
                                      .baseStat = int.parse(value);
                                  model.save();
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ))
                  .toList(),
            ),
          );
        });
  }
}
