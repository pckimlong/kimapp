import 'package:kimapp/kimapp.dart';

@TableStructure(
  '',
  columns: [
    'id',
  ],
)
class DoctorId extends Identity<String> {
  const DoctorId._(this.value);

  @override
  final String value;

  factory DoctorId.fromJson(dynamic value) {
    return DoctorId._(value);
  }

  factory DoctorId.fromValue(String value) {
    return DoctorId._(value);
  }
}


mixin DoctorCommonMixin {
  DoctorId get identity;
}

extension  DoctorCommonX on  DoctorCommonMixin{
  DoctorId get id => identity;
}