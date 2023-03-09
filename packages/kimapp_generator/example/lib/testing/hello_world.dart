import 'package:kimapp/kimapp.dart';

@TableStructure('tableName', columns: ['id'])
class HelloId extends Identity<int> {
  const HelloId._(this.value);

  @override
  final int value;

  factory HelloId.fromJson(dynamic value) {
    return HelloId._(value);
  }
}
