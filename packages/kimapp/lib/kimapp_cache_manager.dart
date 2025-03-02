abstract class KimappCacheManager {
  Future<void> initialize();

  Future<void> save(String key, dynamic value);
  Future<dynamic> read(String key);

  Future<void> saveString(String key, String? value);
  Future<String?> readString(String key);

  Future<void> saveInt(String key, int? value);
  Future<int?> readInt(String key);

  Future<void> saveDouble(String key, double? value);
  Future<double?> readDouble(String key);

  Future<void> saveMap(String key, Map<String, dynamic>? value);
  Future<Map<String, dynamic>?> readMap(String key);

  Future<void> saveEnum<T extends Enum>(String key, T? value);
  Future<T?> readEnum<T extends Enum>(
      String key, T Function(String name) parser);

  Future<void> saveObject<T extends Object>(
    String key, {
    required T? value,
    required Map<String, dynamic> Function(T object) toMap,
  });

  Future<T?> readObject<T extends Object>(
    String key, {
    required T Function(Map<String, dynamic> json) fromMap,
    void Function(Object error, Map<String, dynamic> json)? onFail,
  });

  Future<void> saveList<T extends Object>(
    String key, {
    required List<T> value,
    required Map<String, dynamic> Function(T object) toMap,
  });

  Future<List<T>?> readList<T extends Object>(
    String key, {
    required T Function(Map<String, dynamic> json) fromMap,
    void Function(Object error, Map<String, dynamic> json)? onFail,
  });

  Future<void> saveDateTime(String key, DateTime? dateTime);
  Future<DateTime?> readDateTime(String key);

  Future<void> clear(String key);
}
