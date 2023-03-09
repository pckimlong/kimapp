import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeX on DateTime {
  String formatTimeAgo([bool useKhmer = true]) {
    if (useKhmer) {
      timeago.setLocaleMessages('km', timeago.KmMessages());
      return timeago.format(toLocal(), locale: 'km');
    }
    return timeago.format(toLocal());
  }

  DateTime get dateOnly => DateTime(year, month, day);
  DateTime get firstMinuteOfDay => DateTime(year, month, day);
  DateTime get lastMinuteOfDay => DateTime(year, month, day, 23, 59, 59);

  String format({bool includeDay = true}) {
    return DateFormat('${includeDay ? "EEE, " : ""}dd-MM-yyyy').format(
      toLocal(),
    );
  }

  String formatWithTime() {
    DateFormat.HOUR;
    return DateFormat('dd-MM-yyyy hh:mm a').format(
      toLocal(),
    );
  }
}
