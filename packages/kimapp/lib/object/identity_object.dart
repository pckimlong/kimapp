abstract class Identity<T> {
  const Identity();

  T get value;
  @override
  bool operator ==(covariant Identity<T> other) {
    if (identical(this, other)) return true;
    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  T toJson() {
    if (value is num && (value as num).isNegative) {
      throw ArgumentError('Identity value cannot be negative: $value');
    }

    if (value is String && (value as String).isEmpty) {
      throw ArgumentError('Identity value cannot be empty: $value');
    }

    return value;
  }

  @override
  String toString() => '$value';

  T call() {
    if (value is num && (value as num).isNegative) {
      throw ArgumentError('Identity value cannot be negative: $value');
    }

    if (value is String && (value as String).isEmpty) {
      throw ArgumentError('Identity value cannot be empty: $value');
    }

    return value;
  }
}
