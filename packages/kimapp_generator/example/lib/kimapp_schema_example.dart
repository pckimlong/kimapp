
import 'package:example/kimapp_schema_example.schema.dart';
import 'package:kimapp/kimapp_schema.dart';

@KimappSchema(
  tableName: 'exampleses',
  className: 'Example',
  baseModelName: 'ExampleModel',
  columns: [
    IdField('id', generateAs: 'ExmapleId', type: int),
    Field('name', type: String, addToModels: ['CreateExampleParam']),
    Field('phone', type: String, addToModels: ['CreateExampleParam']),
    Field('kim2', type: int, ignoreRaw: true),
    Field('kim', type: ExampleModel, addToModels: ['CreateExampleParam']),
  ],
  models: [
    Model(name: 'CreateExampleParam', supabaseTable: SupabaseTable()),
    Model(name: 'ExampleView', supabaseTable: SupabaseTable(tableName: 'v_examples'), inheritAllFields: true),
  ]
)
class ExampleSchema {}