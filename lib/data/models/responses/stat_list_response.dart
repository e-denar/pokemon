import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon/data/models/pokemon_stat_model.dart';

part 'stat_list_response.g.dart';

@JsonSerializable()
class StatListResponse {
  const StatListResponse(this.stats);

  factory StatListResponse.fromJson(Map<String, dynamic> json) =>
      _$StatListResponseFromJson(json);

  @JsonKey(name: 'pokemon_v2_pokemonstat')
  final List<StatModel> stats;
}
