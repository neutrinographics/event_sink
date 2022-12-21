import 'dart:convert';

import 'package:event_sync/src/core/error/exception.dart';
import 'package:hive/hive.dart';

/// This provides an abstraction over the cache.
///
/// Any unexpected state should result in a [CacheException]
abstract class LocalCache<K, T> {
  /// Writes a value to the data source.
  Future<void> write(K key, T data);

  /// Reads a value from the data source.
  /// This will raise a [CacheException] if the value does not exist,
  /// or fails to be read from the cache.
  Future<T> read(K key);

  /// Checks if an element exists
  Future<bool> exists(K key);

  /// Returns a list of all values in the data source.
  Future<List<T>> values();

  /// Returns a list of all keys in the data source.
  Future<List<K>> keys();

  /// Removes an item from the data source.
  Future<void> delete(K key);

  /// Truncates all data in the data source.
  Future<void> clear();
}

/// A cache that's only stored in memory.
class MemoryCacheImpl<K, T> implements LocalCache<K, T> {
  final Map<K, T> cache = {};

  @override
  Future<void> write(K key, T data) async {
    cache[key] = data;
  }

  @override
  Future<void> clear() async {
    cache.clear();
  }

  @override
  Future<void> delete(K key) async {
    cache.remove(key);
  }

  @override
  Future<bool> exists(K key) async {
    return cache.containsKey(key);
  }

  @override
  Future<List<K>> keys() async {
    return cache.keys.toList();
  }

  @override
  Future<T> read(K key) async {
    T? result = cache[key];
    if (result == null) {
      throw CacheException(
          message: 'The model identified by $key does not exist');
    }
    return result;
  }

  @override
  Future<List<T>> values() async {
    return cache.values.toList();
  }
}

/// Transforms JSON into a model.
typedef HiveModelLoader<T> = T Function(Map<String, dynamic> json);

class HiveCacheImpl<K, T> implements LocalCache<K, T> {
  final Box box;
  final HiveModelLoader<T> loader;

  HiveCacheImpl({required this.box, required this.loader});

  @override
  Future<void> clear() async {
    try {
      await box.clear();
    } catch (e, trace) {
      throw CacheException(message: '$e\n\n$trace');
    }
  }

  @override
  Future<void> delete(K key) {
    try {
      return box.delete(key);
    } catch (e, trace) {
      throw CacheException(message: '$e\n\n$trace');
    }
  }

  @override
  Future<T> read(K key) async {
    String? result = box.get(key);
    if (result == null) {
      throw CacheException(
        message: 'The model identified by $key does not exist',
      );
    }
    try {
      return loader(json.decode(result));
    } catch (e, trace) {
      throw CacheException(message: '$e\n\n$trace');
    }
  }

  @override
  Future<void> write(K key, T data) {
    try {
      return box.put(key, json.encode(data));
    } catch (e, trace) {
      throw CacheException(message: '$e\n\n$trace');
    }
  }

  @override
  Future<List<K>> keys() async {
    return box.keys.toList() as List<K>;
  }

  @override
  Future<List<T>> values() async {
    List<T> models = [];
    for (String element in box.values) {
      try {
        models.add(loader(json.decode(element)));
      } catch (e, trace) {
        throw CacheException(message: '$e\n\n$trace');
      }
    }
    return models;
  }

  @override
  Future<bool> exists(K key) async {
    return box.containsKey(key);
  }
}
