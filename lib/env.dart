import 'package:flutter/foundation.dart';

enum Environment { debug, profile, release }

/// App's build environment
///
const Environment ENV_ = kDebugMode
    ? Environment.debug
    : kProfileMode
        ? Environment.profile
        : Environment.release;

/// Environment Extensions
///
extension EnvironmentExt on Environment {
  String get name => _envNames[this]!;
  String get baseUrl => _baseUrls[this]!;
  int get load => _paginationLoad[this]!;
}

extension StringEnvExt on String {
  /// Environmentalized form
  ///
  /// Append environment eg: 'MY_STRING' -> 'MY_STRING_DEBUG'.
  /// Commonly used for storage keys to avoid access conflicts
  /// between environment builds when testing.
  ///
  String get envalized => '${this}_${ENV_.name}';
}

// + Constants

const Map<Environment, String> _envNames = <Environment, String>{
  Environment.debug: 'DEBUG',
  Environment.profile: 'PROFILE',
  Environment.release: 'RELEASE',
};

const Map<Environment, String> _baseUrls = <Environment, String>{
  Environment.debug: 'https://beta.pokeapi.co',
  Environment.profile: 'https://beta.pokeapi.co',
  // TODO: Add prod link
  Environment.release: 'https://beta.pokeapi.co',
};

const Map<Environment, int> _paginationLoad = <Environment, int>{
  Environment.debug: 5,
  Environment.profile: 5,
  // TODO: Add load for prod
  Environment.release: 5,
};
