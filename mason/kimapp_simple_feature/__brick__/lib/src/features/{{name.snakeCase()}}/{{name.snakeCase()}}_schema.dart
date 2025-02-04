import 'package:kimapp/kimapp.dart';

@Schema(
  tableName: '{{name.snakeCase()}}s',
  className: '{{name.pascalCase()}}',
  baseModelName: '{{name.pascalCase()}}Model',
)
class {{name.pascalCase()}}Schema extends KimappSchema {
  final id = Field.id<{{id_data_type}}>('id').generateAs('{{name.pascalCase()}}Id');
  final name = Field<String>('name');

  @override
  List<Model> get models {
    return [
      Model('{{name.pascalCase()}}LiteModel')
        ..table()
        ..addFields({'id': id, 'name': name}),
      Model('{{name.pascalCase()}}DetailModel')
        ..table()
        ..inheritAllFromBase()
        ..addFields({
          'createdAt': Field<DateTime>('created_at'),
        }),

      // Params
      Model('{{name.pascalCase()}}CreateParam')..addFields({}),
      Model('{{name.pascalCase()}}UpdateParam')..addFields({}),
    ];
  }
}
