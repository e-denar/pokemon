import 'package:flutter/material.dart';
import 'package:pokemon/data/models/data_object.dart';
import 'package:pokemon/data/repositories/hive_repository.dart';
import 'package:pokemon/viewmodels/cached_view_model.dart';
import 'package:provider/provider.dart';

class CachedView<T extends DataObject> extends StatelessWidget {
  const CachedView({
    Key? key,
    required this.id,
    required this.builder,
    this.loadingBuilder,
  }) : super(key: key);

  final dynamic id;
  final Widget Function(BuildContext, T) builder;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CachedViewModel<T>>(
      key: ValueKey<dynamic>(id),
      create: (BuildContext context) => CachedViewModel<T>(
        id,
        context.read<HiveRepository<T>>(),
      ),
      builder: (BuildContext context, _) => Selector<CachedViewModel<T>, T?>(
        shouldRebuild: (_, __) => true,
        selector: (_, CachedViewModel<T> viewModel) => viewModel.data,
        builder: (BuildContext context, T? value, _) {
          if (value == null) {
            return loadingBuilder?.call(context) ?? const SizedBox();
          }

          return builder.call(context, value);
        },
      ),
    );
  }
}
