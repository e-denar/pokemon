import 'package:flutter/material.dart';
import 'package:pokemon/data/repositories/graphql_service.dart';
import 'package:pokemon/data/repositories/pokemon_hive_repository.dart';
import 'package:pokemon/managers/hive_manager.dart';
import 'package:pokemon/routes/pages.dart';
import 'package:pokemon/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders,
      child: MaterialApp(
        title: 'PocketInv',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.splash,
        routes: Pages.routes,
      ),
    );
  }

  List<SingleChildWidget> get getProviders {
    return <SingleChildWidget>[
      Provider<HiveManager>(
        create: (_) => HiveManager(),
        lazy: false,
      ),
      Provider<GraphQLService>(
        create: (_) => GraphQLService(),
      ),
      Provider<PokemonHiveRepository>(
        create: (BuildContext context) => PokemonHiveRepository(
          graphQLService: context.read<GraphQLService>(),
        ),
      )
    ];
  }
}
