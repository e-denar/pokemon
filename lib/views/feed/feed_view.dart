import 'package:flutter/material.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/routes/routes.dart';
import 'package:pokemon/viewmodels/feed_view_model.dart';
import 'package:pokemon/viewmodels/view_model.dart';
import 'package:provider/provider.dart';

class FeedView extends StatelessWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feed',
        ),
      ),
      body: Selector<FeedViewModel, ViewModelState>(
        selector: (_, FeedViewModel viewModel) => viewModel.state,
        builder: (_, ViewModelState state, __) {
          final Widget child;
          switch (state) {
            case ViewModelState.init:
            case ViewModelState.loading:
              child = const Center(child: CircularProgressIndicator());
              break;
            case ViewModelState.success:
              child = const _PokemonListView();
              break;
            case ViewModelState.error:
              child = const Center(child: Text('Fail'));

              break;
          }

          return child;
        },
      ),
    );
  }
}

class _PokemonListView extends StatelessWidget {
  const _PokemonListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<FeedViewModel, List<PokemonModel>>(
      selector: (_, FeedViewModel viewModel) => viewModel.items,
      builder: (_, List<PokemonModel> items, __) {
        if (items.isEmpty) {
          return const Center(
            child: Text('Empty'),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollState) {
            final double maxScrollExtent = scrollState.metrics.maxScrollExtent;

            if (scrollState.metrics.pixels >= maxScrollExtent) {
              context.read<FeedViewModel>().fetch();
            }
            return false;
          },
          child: ListView.builder(
            itemBuilder: (_, int i) {
              if (i == items.length) {
                return const SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final PokemonModel item = items.elementAt(i);
              final String title = item.name;
              final String imageUrl = item.sprites.first.sprites.imageUrl;
              final String height = item.height.toString();
              final String width = item.weight.toString();
              final String baseXp = item.baseExperience.toString();

              return ListTile(
                onTap: () => _onItemTap(context, item),
                leading: Image.network(
                  imageUrl,
                  height: 40,
                  width: 40,
                ),
                title: Text(title),
                subtitle: Text('height: $height width: $width'),
                trailing: Text(baseXp),
              );
            },
            itemCount: items.length + 1,
          ),
        );
      },
    );
  }

  void _onItemTap(BuildContext context, PokemonModel pokemon) {
    Navigator.of(context).pushNamed(Routes.details, arguments: pokemon);
  }
}
