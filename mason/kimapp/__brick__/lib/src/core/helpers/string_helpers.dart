import 'package:dartx/dartx.dart';

extension NullableStringHelpers on String? {
  String? asNull() => isNullOrBlank ? null : this;
}

extension StringHelpers on String {
  /// Normalizes text by removing spaces and special characters
  /// This makes search more robust by ignoring spaces, hyphens, and other special characters
  String normalizeForSearch() {
    return toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(RegExp(r'\s+'), '');
  }
}
