import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/data/models/pokemon_model.dart';

class HiveManager {
  final Completer<void> _initCompleter = Completer<void>();

  Future<void> initialize() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PokemonModelAdapter());
    _initCompleter.complete();
  }
}
