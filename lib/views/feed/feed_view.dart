import 'package:flutter/material.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/routes/routes.dart';
import 'package:pokemon/viewmodels/feed_view_model.dart';
import 'package:pokemon/viewmodels/view_model.dart';
import 'package:pokemon/views/widgets/cached_view.dart';
import 'package:pokemon/views/widgets/search_dialog_box.dart';
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearchDialogBox(context, (String value) async {
                final FeedViewModel viewModel = context.read<FeedViewModel>();
                await viewModel.search(value);
              });
            },
            icon: const Icon(Icons.search),
          )
        ],
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
      shouldRebuild: (_, __) => true,
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
              itemCount: items.length,
              itemBuilder: (BuildContext context, int i) {
                return CachedView<PokemonModel>(
                  id: items[i].id,
                  builder: (BuildContext context, PokemonModel item) {
                    final String title = item.name;
                    final String imageUrl = item.imageUrl;
                    final String height = item.height.toString();
                    final String width = item.weight.toString();
                    final String baseXp = item.baseExperience.toString();

                    return ListTile(
                      onTap: () => _onItemTap(context, items[i]),
                      leading: Image.network(
                        imageUrl,
                        height: 40,
                        width: 40,
                        errorBuilder: (_, __, ___) => const Text('Image Error'),
                      ),
                      title: Text(title),
                      subtitle: Text('height: $height weight: $width'),
                      trailing: Text(baseXp),
                    );
                  },
                );
              }),
        );
      },
    );
  }

  void _onItemTap(BuildContext context, PokemonModel pokemon) {
    Navigator.of(context).pushNamed(Routes.details, arguments: pokemon);
  }
}
