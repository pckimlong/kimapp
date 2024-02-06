import 'package:hive_flutter/hive_flutter.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../commons.dart';

part "cache_manager_provider.g.dart";

@Riverpod(keepAlive: true)
FutureOr<KimappCacheManager> cacheManager(CacheManagerRef ref) async {
  final storage = HiveCacheManager();
  await storage.initialize();
  return storage;
}

const String _keyValueBox = "key_value";

class HiveCacheManager extends KimappCacheManager with LoggerMixin {
  late Box _box;

  @override
  Future<T?> readEnum<T extends Enum>(String key, T Function(String name) parser) async {
    final result = await read(key);
    if (result is String) {
      return parser(result);
    }
    return null;
  }

  @override
  Future<void> saveEnum<T extends Enum>(String key, T? value) async {
    final name = value?.name;
    await save(key, name);
  }

  @override
  Future<List<T>?> readList<T extends Object>(
    String key, {
    required T Function(Map<String, dynamic> json) fromMap,
    void Function(Object error, Map<String, dynamic> json)? onFail,
  }) async {
    final data = await readMap(key);
    if (data == null) return null;

    try {
      return [for (final m in data.values) m].map((e) => fromMap(_mapParser(e)!)).toList();
    } catch (e) {
      logger.e('Error reading object from local storage with key [$key], Null will be return');
      if (onFail != null) {
        onFail(e, data);
      }
      return null;
    }
  }

  @override
  Future<T?> readObject<T extends Object>(
    String key, {
    required T Function(Map<String, dynamic> json) fromMap,
    void Function(Object error, Map<String, dynamic> json)? onFail,
  }) async {
    final data = await readMap(key);
    if (data == null) return null;

    try {
      return fromMap(data);
    } catch (e) {
      logger.e('Error reading object from local storage with key [$key], Null will be return');
      if (onFail != null) {
        onFail(e, data);
      }
      return null;
    }
  }

  @override
  Future<void> saveList<T extends Object>(
    String key, {
    required List<T> value,
    required Map<String, dynamic> Function(T object) toMap,
  }) async {
    final map = {
      for (var i = 0; i < value.length; i++) i.toString(): toMap(value[i]),
    };
    await saveMap(key, map);
  }

  @override
  Future<void> saveObject<T extends Object>(
    String key, {
    required T? value,
    required Map<String, dynamic> Function(T object) toMap,
  }) async {
    if (value == null) clear(key);
    final map = toMap(value as T);
    await saveMap(key, map);
  }

  @override
  Future<void> clear(String key) async {
    await Hive.box(_keyValueBox).delete(key);
  }

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_keyValueBox);
  }

  @override
  Future read(String key) async {
    final result = await _box.get(key);
    if (result == null) return null;
    return result;
  }

  @override
  Future<DateTime?> readDateTime(String key) async {
    final result = await readInt(key);
    if (result != null) return DateTime.fromMillisecondsSinceEpoch(result);
    return null;
  }

  @override
  Future<double?> readDouble(String key) async {
    final result = await read(key);
    if (result is double?) return result;
    return null;
  }

  @override
  Future<int?> readInt(String key) async {
    final result = await read(key);
    if (result is int?) return result;
    return null;
  }

  @override
  Future<Map<String, dynamic>?> readMap(String key) async {
    final data = await read(key);
    if (data == null) return null;
    return _mapParser(data);
  }

  @override
  Future<String?> readString(String key) async {
    final result = await read(key);
    if (result is String?) return result;
    return null;
  }

  @override
  Future<void> save(String key, value) async {
    if (value == null) {
      await clear(key);
    }
    await Hive.box(_keyValueBox).put(key, value);
  }

  @override
  Future<void> saveDateTime(String key, DateTime? dateTime) async {
    await saveInt(key, dateTime?.millisecondsSinceEpoch);
  }

  @override
  Future<void> saveDouble(String key, double? value) async {
    await save(key, value);
  }

  @override
  Future<void> saveInt(String key, int? value) async {
    await save(key, value);
  }

  @override
  Future<void> saveMap(String key, Map<String, dynamic>? value) async {
    await save(key, value);
  }

  @override
  Future<void> saveString(String key, String? value) async {
    await save(key, value);
  }

  Map<String, dynamic>? _mapParser(Map<dynamic, dynamic> data) {
    final Map<dynamic, dynamic> currentValue = data;
    final Map<String, dynamic> tmp = currentValue.map((key, v) => MapEntry(key.toString(), v));
    return tmp;
  }
}
