import 'package:kimapp/kimapp.dart';

import '{{name.snakeCase()}}_schema.schema.dart';

export '{{name.snakeCase()}}_schema.schema.dart';

const _create{{name.pascalCase()}}Param = 'Create{{name.pascalCase()}}Param';
const _update{{name.pascalCase()}}Param = 'Update{{name.pascalCase()}}Param';

@KimappSchema(
  tableName: '{{name.snakeCase()}}s',
  className: '{{name.pascalCase()}}',
  fields: [
    IdField(
      'id',
      generateAs: '{{name.pascalCase()}}Id',
      type: T(int),
      addToModels: [
        _create{{name.pascalCase()}}Param,
        _update{{name.pascalCase()}}Param,
      ],
    ),
    Field(
      'name',
      type: T(String),
      addToModels: [
        _create{{name.pascalCase()}}Param,
        _update{{name.pascalCase()}}Param,
      ],
    ),
  ],
  models: [
    Model(name: _create{{name.pascalCase()}}Param),
    Model(name: _update{{name.pascalCase()}}Param),
  ],
)
typedef {{name.pascalCase()}}Model = {{name.pascalCase()}}RawModel;
