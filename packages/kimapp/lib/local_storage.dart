abstract class LocalStorage {
  LocalStorage({
    required this.initialize,
    required this.clear,
    required this.save,
    required this.read,
    required this.saveMap,
    required this.readMap,
    required this.saveObject,
    required this.readObject,
    required this.saveString,
    required this.readString,
    required this.saveInt,
    required this.readInt,
    required this.saveEnum,
    required this.readEnum,
  });

  final Future<void> Function() initialize;

  final Future<void> Function(String key, dynamic value) save;
  final Future<dynamic> Function(String key) read;

  final Future<void> Function(String key, {required String? value}) saveString;
  final Future<String?> Function(String key) readString;

  final Future<void> Function(String key, {required int? value}) saveInt;
  final Future<int?> Function(String key) readInt;

  final Future<void> Function(String key, {required double? value}) saveDouble;
  final Future<double?> Function(String key) readDouble;

  final Future<void> Function(String key, {required Map<String, dynamic>? value}) saveMap;
  final Future<Map<String, dynamic>?> Function(String key) readMap;

  final Future<void> Function<T extends Enum>(String key, {required T? value}) saveEnum;
  final Future<T?> Function<T extends Enum>(String key) readEnum;

  final Future<void> Function<T extends Object>(String key,
      {required T? value, required Map<String, dynamic> Function(T object) toMap}) saveObject;

  final Future<T?> Function<T extends Object>(String key,
      {required T Function(Map<String, dynamic> json) fromMap,
      void Function(Object error, Map<String, dynamic> json)? onFail}) readObject;

  final Future<void> Function(String key) clear;
}
