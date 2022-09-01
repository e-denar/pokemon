import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon/common/constants/hive_type_ids.dart';
import 'package:pokemon/data/models/data_object.dart';

part 'pokemon_stat_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@HiveType(typeId: HiveTypeIds.pokemonStatId)
class PokemonStatModel extends DataObject {
  PokemonStatModel(
    int id,
    this.stats,
  ) : super(id: id);

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatModelToJson(this);

  @HiveField(1)
  List<StatModel> stats;
}

@JsonSerializable(fieldRename: FieldRename.snake)
@HiveType(typeId: HiveTypeIds.pokemonStatModelId)
class StatModel extends DataObject {
  StatModel(
    int id,
    this.baseStat,
    this.effort,
    this.name,
  ) : super(id: id);

  factory StatModel.fromJson(Map<String, dynamic> json) =>
      _$StatModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatModelToJson(this);

  @HiveField(1)
  int baseStat;

  @HiveField(2)
  int effort;

  @JsonKey(name: 'pokemon_v2_stat', fromJson: _statDecoder)
  @HiveField(3)
  String name;
}

@JsonSerializable()
class Stat {
  Stat(this.name);

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);

  final String name;
}

String _statDecoder(Map<String, dynamic> json) {
  return Stat.fromJson(json).name;
}
