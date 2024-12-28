import '../../../exports.dart';

extension TimeX on TimeOfDay {
  int toMinute() {
    return (hour * 60) + minute;
  }

  bool isBefore(TimeOfDay other) {
    return toMinute() < other.toMinute();
  }

  bool isAfter(TimeOfDay other) {
    return toMinute() > other.toMinute();
  }

  bool isBeforeEqual(TimeOfDay other) {
    return toMinute() <= other.toMinute();
  }

  bool isAfterEqual(TimeOfDay other) {
    return toMinute() >= other.toMinute();
  }
}
