import 'package:kimapp/kimapp.dart';

class UserId extends Identity<String> {
  const UserId._(this.value);

  @override
  final String value;

  factory UserId.fromJson(dynamic value) {
    return UserId._(value);
  }
  factory UserId.fromValue(String value) {
    return UserId._(value);
  }
}