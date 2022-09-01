import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/data/models/models.barrel.dart';
import 'package:pokemon/data/repositories/hive_repository.dart';
import 'package:pokemon/data/repositories/pokemon_hive_repository.dart';
import 'package:pokemon/routes/pages.dart';
import 'package:pokemon/viewmodels/feed_view_model.dart';
import 'package:pokemon/views/feed/feed_view.dart';
import 'package:provider/provider.dart';

import 'feed_view_test.mocks.dart';

@GenerateMocks(
  <Type>[
    PokemonHiveRepository,
    Box,
  ],
  customMocks: <MockSpec<dynamic>>[
    MockSpec<NavigatorObserver>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
  ],
)
void main() {
  final MockPokemonHiveRepository repository = MockPokemonHiveRepository();
  final MockBox<PokemonModel> box = MockBox<PokemonModel>();
  final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

  Future<void> buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(Provider<HiveRepository<PokemonModel>>.value(
      value: repository,
      child: MaterialApp(
        home: ChangeNotifierProvider<FeedViewModel>(
          create: (_) => FeedViewModel(repository),
          child: const FeedView(),
        ),
        navigatorObservers: [navigatorObserver],
        routes: Pages.routes,
      ),
    ));
  }

  testWidgets('Loading check', (tester) async {
    await buildWidget(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    verify(repository.fetchPokemons(offset: 0)).called(1);
    verifyNoMoreInteractions(repository);
  });

  testWidgets('Error check', (tester) async {
    when(repository.fetchPokemons(offset: anyNamed('offset')))
        .thenThrow(Exception());
    await buildWidget(tester);
    await tester.pump();

    expect(find.text('Fail'), findsOneWidget);

    verify(repository.fetchPokemons(offset: 0)).called(1);
    verifyNoMoreInteractions(repository);
  });

  testWidgets('Empty check', (tester) async {
    when(repository.fetchPokemons(offset: anyNamed('offset')))
        .thenAnswer((_) => Future<List<PokemonModel>>.value(<PokemonModel>[]));
    await buildWidget(tester);
    await tester.pump();

    expect(find.text('Empty'), findsOneWidget);
    verify(repository.fetchPokemons(offset: 0)).called(1);
    verifyNoMoreInteractions(repository);
  });

  testWidgets('Success check', (tester) async {
    final PokemonModel pokemonModel =
        PokemonModel(1, 'somePokemon', 10, 20, 30, 'https://dummyurl.com');
    final ValueListenable<Box<PokemonModel>> listenable =
        ValueNotifier<Box<PokemonModel>>(box);
    when(box.get(any)).thenReturn(pokemonModel);
    when(repository.fetchPokemons(offset: anyNamed('offset'))).thenAnswer((_) {
      return Future<List<PokemonModel>>.value(<PokemonModel>[pokemonModel]);
    });

    when(repository.getListenable(key: 1))
        .thenAnswer((_) => Future.value(listenable));
    await buildWidget(tester);
    await tester.pumpAndSettle();

    expect(find.text('somePokemon'), findsOneWidget);
    expect(find.text('height: 10 weight: 20'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    verify(repository.fetchPokemons(offset: 0)).called(1);
    verify(repository.getListenable(key: pokemonModel.id)).called(1);

    verifyNoMoreInteractions(repository);

    await tester.tap(find.text('somePokemon'));
    verify(navigatorObserver.didPush(any, any));
  });
}
