import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon/data/models/data_object.dart';

mixin HiveServiceMixin<D extends StatefulWidget, T extends DataObject>
    on State<D> {
  ValueListenable<Box<T>>? listenable;

  @protected
  int get id;

  /// Builder function which have access to cache.
  Widget viewBuilder(BuildContext context, T item);

  /// Builder function to show loading state
  WidgetBuilder? loadingBuilder;

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    Hive.openBox<T>(T.toString()).then((Box<T> box) {
      setState(() {
        listenable = box.listenable(keys: <dynamic>[id]);
      });
    });
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (listenable == null) {
      return loadingBuilder?.call(context) ?? const SizedBox();
    }

    return ValueListenableBuilder<Box<T>>(
      valueListenable: listenable!,
      builder: (BuildContext context, Box<T> listenable, _) {
        if (!listenable.containsKey(id)) {
          return const SizedBox();
        }

        return viewBuilder(
          context,
          listenable.get(id)!,
        );
      },
    );
  }
}
