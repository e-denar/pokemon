import 'package:flutter/material.dart';
import 'package:pokemon/data/models/models.barrel.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';
import 'package:pokemon/data/repositories/pokemon_hive_repository.dart';
import 'package:pokemon/routes/routes.dart';
import 'package:pokemon/viewmodels/detail_view_model.dart';
import 'package:pokemon/viewmodels/feed_view_model.dart';
import 'package:pokemon/views/detail/detail_view.dart';
import 'package:pokemon/views/feed/feed_view.dart';
import 'package:pokemon/views/splash/splash_view.dart';
import 'package:provider/provider.dart';

class Pages {
  Pages._();

  static final Map<String, Widget Function(BuildContext)> routes =
      <String, Widget Function(BuildContext)>{
    /// To [SplashView]
    Routes.splash: (_) => const SplashView(),

    /// To [FeedView]
    Routes.feed: (BuildContext context) =>
        ChangeNotifierProvider<FeedViewModel>(
          create: (_) => FeedViewModel(
            context.read<PokemonHiveRepository>(),
          ),
          child: const FeedView(),
        ),

    /// To [DetailView]
    Routes.details: (BuildContext context) {
      final PokemonModel? pokemon =
          ModalRoute.of(context)!.settings.arguments as PokemonModel?;

      if (pokemon == null) {
        // TODO: navigate to invalid page
      }

      return ChangeNotifierProvider<DetailViewModel>(
        create: (_) => DetailViewModel(
          pokemon!,
          context.read<GraphQLService>(),
        ),
        child: const DetailView(),
      );
    }
  };
}
