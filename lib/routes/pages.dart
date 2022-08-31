import 'package:flutter/material.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';
import 'package:pokemon/routes/routes.dart';
import 'package:pokemon/viewmodels/feed_view_model.dart';
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
            context.read<GraphQLService>(),
          ),
          child: const FeedView(),
        )
  };
}
