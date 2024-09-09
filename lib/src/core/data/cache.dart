import 'package:clean_cache/cache/hybrid_cache.dart';
import 'package:clean_cache/cache/memory_cache.dart';
import 'package:clean_cache/clean_cache.dart';
import 'package:hive/hive.dart';

/// Utility to create a hybrid cache from Hive and Memory.
Future<HybridCache<K, T>> buildHybridHiveCache<K, T>(String boxName,
    {HiveCipher? encryptionCipher}) async {
  final slowCache =
      await buildHiveCache<K, T>(boxName, encryptionCipher: encryptionCipher);
  final fastCache = MemoryCache<K, T>();
  return HybridCache(
    slowCache: slowCache,
    fastCache: fastCache,
  );
}

/// Utility to create a Hive cache.
Future<HiveCache<K, T>> buildHiveCache<K, T>(String boxName,
    {HiveCipher? encryptionCipher}) {
  return Hive.openBox<T>(boxName, encryptionCipher: encryptionCipher)
      .then((value) {
    return HiveCache<K, T>(box: value);
  });
}

class HiveCache<K, T> implements CleanCache<K, T> {
  final Box<T> box;

  HiveCache({required this.box});

  @override
  Future<void> clear() async {
    await box.clear();
  }

  @override
  Future<void> delete(K key) {
    return box.delete(key);
  }

  @override
  Future<T> read(K key) async {
    final result = box.get(key);
    if (result == null) {
      throw Exception("Missing record $key");
    }
    return result;
  }

  @override
  Future<void> write(K key, T data) {
    return box.put(key, data);
  }

  @override
  Future<void> writeAll(Map<K, T> data) async {
    await box.putAll(data);
  }

  @override
  Future<List<K>> keys() async {
    return box.keys.toList() as List<K>;
  }

  @override
  Future<List<T>> values() async {
    return box.values.toList();
  }

  @override
  Future<bool> exists(K key) async {
    return box.containsKey(key);
  }
}
