import 'package:kimapp/kimapp.dart';

import '{{name.snakeCase()}}_schema.schema.dart';

export '{{name.snakeCase()}}_schema.schema.dart';

@KimappSchema(
  tableName: '{{name.snakeCase()}}s',
  className: '{{name.pascalCase()}}',
  columns: [
    IdField('id', generateAs: '{{name.pascalCase()}}Id', type: {{id_data_type}}),
    Field(
      'name',
      type: String,
      addToModels: [
        'Create{{name.pascalCase()}}Param',
        'Update{{name.pascalCase()}}Param',
      ],
    ),
  ],
  models: [
    Model(name: 'Create{{name.pascalCase()}}Param'),
    Model(name: 'Update{{name.pascalCase()}}Param'),
  ],
)
typedef {{name.pascalCase()}}Model = {{name.pascalCase()}}RawModel;
