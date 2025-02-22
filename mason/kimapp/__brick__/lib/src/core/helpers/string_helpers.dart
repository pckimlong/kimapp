import 'package:dartx/dartx.dart';

extension StringHelpers on String? {
  String? asNull() => isNullOrBlank ? null : this;
}
