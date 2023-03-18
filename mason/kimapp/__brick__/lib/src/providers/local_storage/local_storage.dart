import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exports.dart';

part "local_storage.g.dart";

@Riverpod(keepAlive: true)
FutureOr<LocalStorage> localStorage(LocalStorageRef ref) async {
  final storage = HiveLocalStorage();
  await storage.initialize();
  return storage;
}

const String _keyValueBox = "key_value";

class HiveLocalStorage extends LocalStorage {
  HiveLocalStorage()
      : super(
          initialize: _initialize,
          clear: _clear,
          save: _save,
          read: _read,
          saveMap: _saveMap,
          readMap: _readMap,
          saveObject: _saveObject,
          readObject: _readObject,
          saveString: _saveString,
          readString: _readString,
          saveInt: _saveInt,
          readInt: _readInt,
          saveDouble: _saveDouble,
          readDouble: _readDouble,
          saveEnum: _saveEnum,
          readEnum: _readEnum,
        );

  static Future<void> _initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(_keyValueBox);
  }

  static Future<void> _clear(String key) async {
    await Hive.box(_keyValueBox).delete(key);
  }

  static Future<void> _saveString(String key, {required String? value}) async {
    return _save(key, value);
  }

  static Future<void> _save(String key, dynamic value) async {
    if (value == null) {
      await Hive.box(_keyValueBox).delete(key);
    }
    await Hive.box(_keyValueBox).put(key, value);
  }

  static Future<dynamic> _read(String key) async {
    final result = await Hive.box(_keyValueBox).get(key);
    if (result == null) return null;
    return result;
  }

  static Future<void> _saveMap(String key, {required Map<String, dynamic>? value}) =>
      _save(key, value);

  static Future<Map<String, dynamic>?> _readMap(String key) async {
    final data = await _read(key);
    if (data is Map<String, dynamic>) return data;
    log('Local storage with key [$key] is not of type map');
    return null;
  }

  static Future<void> _saveObject<T extends Object>(
    String key, {
    required T? value,
    required Map<String, dynamic> Function(T object) toMap,
  }) async {
    if (value == null) _clear(key);
    final map = toMap(value as T);
    await _saveMap(key, value: map);
  }

  static Future<T?> _readObject<T extends Object>(
    String key, {
    required T Function(Map<String, dynamic> json) fromMap,
    void Function(Object error, Map<String, dynamic> json)? onFail,
  }) async {
    final data = await _readMap(key);
    if (data == null) return null;

    try {
      return fromMap(data);
    } catch (e) {
      log('Error reading object from local storage with key [$key], Null will be return');
      if (onFail != null) {
        onFail(e, data);
      }
      return null;
    }
  }

  static Future<String?> _readString(String key) async {
    final result = await _read(key);
    if (result is String?) return result;
    return null;
  }

  static Future<void> _saveInt(String key, {required int? value}) {
    return _save(key, value);
  }

  static Future<int?> _readInt(String key) async {
    final result = await _read(key);
    if (result is int?) return result;
    return null;
  }

  static Future<void> _saveDouble(String key, {required double? value}) {
    return _save(key, value);
  }

  static Future<double?> _readDouble(String key) async {
    final result = await _read(key);
    if (result is double?) return result;
    return null;
  }

  static Future<void> _saveEnum<T extends Enum>(String key, {required T? value}) async {
    final name = value?.name;
    await _save(key, name);
  }

  static Future<T?> _readEnum<T extends Enum>(
    String key, {
    required T Function(String name) parser,
  }) async {
    final result = await _read(key);
    if (result is String) {
      return parser(result);
    }
    return null;
  }
}
