import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseLocalDataSource<T> {
  final Box<T> box;
  final String key; // The key used to store the data

  BaseLocalDataSource({required this.box, required this.key});

  Future<void> cache(T data) async {
    await box.put(key, data);
  }

  T? getLastCached() {
    return box.get(key);
  }
}