

import 'package:kimapp/kimapp_schema.dart';


@KimappSchema(
  tableName: 'exampleses',
  className: 'Example',
  baseModelName: 'Example2Model',
  fields: [
    IdField('id', generateAs: 'ExmapleId', type: T(int)),
    Field('name', type: T(String), addToModels: ['CreateExampleParam']),
    Field('phone', type: T(String), addToModels: ['CreateExampleParam']),

  ],
  models: [
    Model(name: 'CreateExampleParam', supabaseTable: SupabaseTable()),
    Model(name: 'ExampleView', supabaseTable: SupabaseTable(tableName: 'v_examples'), inheritAllFields: true),
  ],
)
class ExampleSchema {}

