// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonStatModelAdapter extends TypeAdapter<PokemonStatModel> {
  @override
  final int typeId = 2;

  @override
  PokemonStatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonStatModel(
      fields[0] as int,
      (fields[1] as List).cast<StatModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonStatModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.stats)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonStatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatModelAdapter extends TypeAdapter<StatModel> {
  @override
  final int typeId = 3;

  @override
  StatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StatModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.baseStat)
      ..writeByte(2)
      ..write(obj.effort)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonStatModel _$PokemonStatModelFromJson(Map<String, dynamic> json) =>
    PokemonStatModel(
      json['id'] as int,
      (json['stats'] as List<dynamic>)
          .map((e) => StatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonStatModelToJson(PokemonStatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stats': instance.stats,
    };

StatModel _$StatModelFromJson(Map<String, dynamic> json) => StatModel(
      json['id'] as int,
      json['base_stat'] as int,
      json['effort'] as int,
      _statDecoder(json['pokemon_v2_stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatModelToJson(StatModel instance) => <String, dynamic>{
      'id': instance.id,
      'base_stat': instance.baseStat,
      'effort': instance.effort,
      'pokemon_v2_stat': instance.name,
    };

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      json['name'] as String,
    );

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'name': instance.name,
    };
