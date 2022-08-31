import 'package:hive/hive.dart';

abstract class DataObject extends HiveObject {
  DataObject({
    required this.id,
  });

  @HiveField(0)
  final String id;
}
