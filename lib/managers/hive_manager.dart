import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/data/models/pokemon_model.dart';
import 'package:pokemon/data/models/pokemon_stat_model.dart';

class HiveManager {
  HiveManager() {
    initialize();
  }

  final Completer<void> _initCompleter = Completer<void>();

  Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PokemonModelAdapter());
    Hive.registerAdapter(PokemonStatModelAdapter());
    Hive.registerAdapter(StatModelAdapter());

    _initCompleter.complete();
  }
}
