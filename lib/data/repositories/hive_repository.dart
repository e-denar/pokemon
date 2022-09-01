import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/data/models/data_object.dart';

abstract class HiveRepository<T extends DataObject> {
  Future<T?> get(String key) async {
    final Box<T> box = await _getBox();

    return box.get(key);
  }

  Future<ValueListenable<Box<T>>> getListenable({dynamic key}) async {
    final Box<T> box = await _getBox();
    return box.listenable(keys: <dynamic>[key]);
  }

  Future<List<T>> getAll() async {
    final Box<T> box = await _getBox();

    return box.values.toList();
  }

  Future<T?> firstWhere(bool Function(T r) test) async {
    final List<T> list = await getAll();

    if (list.any(test)) {
      return list.firstWhere(test);
    } else {
      return null;
    }
  }

  Future<List<T>> where(bool Function(T r) test) async {
    return (await getAll()).where(test).toList();
  }

  Future<void> insert(T row) async {
    final Box<T> box = await _getBox();
    await box.put(row.id, row);
  }

  Future<void> insertAll(List<T> rows) async {
    // ignore: prefer_foreach
    for (final T e in rows) {
      insert(e);
    }
  }

  Future<void> update(T row) async {
    await row.save();
  }

  Future<void> delete(dynamic key) async {
    final Box<T> box = await _getBox();
    await box.delete(key);
  }

  Future<void> deleteAll() async {
    final Box<T> box = await _getBox();
    await box.clear();
  }

  Future<Box<T>> _getBox() => Hive.openBox<T>(T.toString());
}
