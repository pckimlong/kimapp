import 'package:kimapp/kimapp.dart';

@TableStructure(
  '{{name.snakeCase()s}}',
  columns: [
    'id',
  ],
)
class {{name.pascalCase()}}Id extends Identity<{{id_data_type}}> {
  const {{name.pascalCase()}}Id._(this.value);

  @override
  final {{id_data_type}} value;

  factory {{name.pascalCase()}}Id.fromJson(dynamic value) {
    return {{name.pascalCase()}}Id._(value);
  }

  factory {{name.pascalCase()}}Id.fromValue({{id_data_type}} value) {
    return {{name.pascalCase()}}Id._(value);
  }
}
