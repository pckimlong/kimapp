extension FutureErrorX<T> on Future<T> {
  Future<void> suppressError({bool Function(Object e)? shouldSuppressError}) async {
    try {
      await this;
    } catch (e) {
      if (shouldSuppressError?.call(e) ?? true) return;
      rethrow;
    }
  }
}
