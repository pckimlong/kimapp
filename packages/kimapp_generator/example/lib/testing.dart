import 'package:example/freezed_model.dart';
import 'package:example/kimapp_schema_example.schema.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp/kimapp_schema.dart';

@KimappSchema(
  tableName: 'testings',
  className: 'Testing',
  baseModelName: 'TestingModel',
  fields: [
    IdField('id', generateAs: 'TestingId', type: T(int)),
    Field('name', type: T(String)),
    Field('phone', type: T(String)),
    Field('address', type: T(String)),
    Field('null_column', type: T(String, '?')),
    Field('no_included'),
    JoinField('selfref', type: T(Example2Model, 'Example2Model?')),
    JoinField('freezedClass', type: T(FreezedModel, 'FreezedModel')),
  ],
  models: [
    Model(name: 'TestingView', supabaseTable: SupabaseTable(tableName: 'v_testings'), inheritAllFields: true),
  ]
)
class Testing {} 