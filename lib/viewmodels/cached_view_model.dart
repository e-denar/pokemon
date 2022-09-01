import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/data/models/data_object.dart';
import 'package:pokemon/data/repositories/hive_repository.dart';
import 'package:pokemon/viewmodels/view_model.dart';

class CachedViewModel<T extends DataObject> extends ViewModel {
  CachedViewModel(this.id, this.repository) {
    init();
  }

  final dynamic id;
  final HiveRepository<T> repository;

  late final ValueListenable<Box<T>> _listenable;

  T? _data;
  T? get data => _data;

  Future<void> init() async {
    try {
      startLoading();
      _listenable = await repository.getListenable(key: id);
      _data = _listenable.value.get(id);
      _listenable.addListener(_updateState);
      stopLoading();
    } catch (e) {
      startError();
    }
  }

  @override
  void dispose() {
    _listenable.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    _data = _listenable.value.get(id);
    notifyListeners();
  }
}
