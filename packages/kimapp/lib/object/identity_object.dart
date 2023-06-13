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

  T toJson() => value;

  @override
  String toString() => '$value';

  T call() => value;
}
