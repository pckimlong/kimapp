import 'package:kimapp/kimapp.dart';

export '{{name.snakeCase()}}_schema.schema.dart';

const _create = 'Create{{name.pascalCase()}}Param';
const _update = 'Update{{name.pascalCase()}}Param';
const _lite = '{{name.pascalCase()}}LiteModel';

@KimappSchema(
  tableName: '{{name.snakeCase()}}s',
  className: '{{name.pascalCase()}}',
  baseModelName: '{{name.pascalCase()}}Model',
  fields: [
    IdField('id', generateAs: '{{name.pascalCase()}}Id', type: T({{id_data_type}}), addToModels: [_create, _update, _lite]),
    Field('name', type: T(String), addToModels: [_create, _update, _lite]),
  ],
  models: [
    Model(name: _create),
    Model(name: _update),
    Model(name: _lite),
  ],
)
abstract class {{name.pascalCase()}}Schema {}



