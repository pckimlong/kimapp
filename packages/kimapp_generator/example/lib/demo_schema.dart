import 'package:kimapp/kimapp.dart';

import 'other_schema.schema.dart';

@Schema(tableName: 'demos', className: 'Demo', baseModelName: 'DemoModel')
class Demo extends KimappSchema {
  Demo._();
  final id = Field.id<int>('id').generateAs('DemoId');
  final name = Field<String?>('name');
  final description = Field<String?>('description');
  final age = Field<int>('age');
  final address = Field<String?>('address');
  final other = Field.join<OtherModel?>().withForeignKey('other_id');

  @override
  List<Model> get models {
    return [
      Model('DemoDetailModel')
        ..table('v_demo_detail').addFields({
          'id': id,
        }),
      Model('DemoLiteModel')
        ..table('test')
        ..addFields({
          'demoId': id,
          'description': Field<String?>('description'),
        }),
    ];
  }
}
