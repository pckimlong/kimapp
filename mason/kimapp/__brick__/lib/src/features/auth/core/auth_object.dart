import 'package:kimapp/kimapp.dart';

class AuthUserId extends Identity<String> {
  const AuthUserId._(this.value);

  @override
  final String value;

  factory AuthUserId.fromJson(dynamic value) {
    return AuthUserId._(value);
  }
  factory AuthUserId.fromValue(String value) {
    return AuthUserId._(value);
  }
}
