
import 'package:kimapp/kimapp_schema.dart';

@KimappSchema(
  tableName: 'exampleses',
  className: 'Example',
  baseModelName: 'ExampleModel',
  columns: [
    IdField('id', generateAs: 'ExmapleId', type: int),
    Field('name', type: String, addToModels: ['CreateExampleParam']),
    Field('age', type: int, addToModels: ['CreateExampleParam']),
  ],
  models: [
    Model(name: 'CreateExampleParam', supabaseTable: SupabaseTable()),
    Model(name: 'UpdateExampleParam', supabaseTable: SupabaseTable()),
    Model(name: 'ExampleView', supabaseTable: SupabaseTable(tableName: 'v_examples')),
  ]
)
class ExampleSchema {}