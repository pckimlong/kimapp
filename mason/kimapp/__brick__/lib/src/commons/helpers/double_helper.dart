// Package imports:
import 'package:intl/intl.dart';

extension DoubleX on double {
  String formatRiel([int decimalDigits = 2, String currency = " ៛"]) {
    String decimal;
    if (decimalDigits < 1) {
      decimal = "";
    } else {
      decimal = ".${"0" * decimalDigits}";
    }

    return NumberFormat.currency(
      customPattern: '#,###$decimal$currency',
      decimalDigits: decimalDigits,
    ).format(this);
  }

  String removeTrailingZeros() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 1);
  }

  String currencyString({double? toDollarExchangeRate}) {
    if (toDollarExchangeRate != null) {
      final formatter = NumberFormat.simpleCurrency(name: 'USD');
      return formatter.format(this * toDollarExchangeRate);
    }

    final formatter = NumberFormat.simpleCurrency(name: 'CNY');
    return formatter.format(this);
  }
}
