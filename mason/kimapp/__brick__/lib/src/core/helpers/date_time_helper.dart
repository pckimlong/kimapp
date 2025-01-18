import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeX on DateTime {
  String formatKhmerFull({bool includeTime = false}) {
    return DateFormat('dd MMM yyyy${includeTime ? " h:mm a" : ""}', 'km').format(this);
  }

  String toTimeAgo() => timeago.format(this, locale: 'km');

  String formatShort({bool includeTime = false, String separator = "/"}) {
    return DateFormat('dd${separator}MM${separator}yyyy${includeTime ? " h:mm a" : ""}')
        .format(this);
  }

  DateTime dateOnly() => DateTime(year, month, day);
  DateTime firstMinuteOfDay() => DateTime(year, month, day);
  DateTime lastMinuteOfDay() => DateTime(year, month, day, 23, 59, 59, 59);

  String format([bool includeDay = true, bool useYtdTodayTmr = false]) {
    if (useYtdTodayTmr) {
      if (isToday) {
        return "ថ្ងៃនេះ";
      } else if (isTomorrow) {
        return "ថ្ងៃស្អែក";
      } else if (wasYesterday) {
        return "ម្សិលមិញ";
      }
    }

    return DateFormat('${includeDay ? "EEE, " : ""}dd-MM-yyyy').format(toLocal());
  }

  String formatTimeOnly() {
    return DateFormat('hh:mm a').format(toLocal());
  }

  String formatWithTime() {
    return DateFormat('dd-MM-yyyy hh:mm a').format(toLocal());
  }
}
