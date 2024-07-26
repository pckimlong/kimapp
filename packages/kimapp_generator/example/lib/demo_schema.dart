import 'package:kimapp/kimapp.dart';

import 'other_schema.schema.dart';

@Schema(tableName: 'demos', className: 'Demo', baseModelName: 'DemoModel')
class Demo extends KimappSchema {
  Demo._();
  final id = Field.id<int>('id').generateAs('DemoId');
  final name = Field<String?>('name');
  final description = Field<String?>('description');
  final ignore = Field.ignore('filter_key');
  final other = Field.join<OtherModel?>().withForeignKey('other_id');

  @override
  List<Model> get models {
    return [
      Model('DemoDetailModel')
        ..table('v_demo_detail')
        ..addFields({'id': id, 'name': name})
        ..inheritAllFromBase(),
      Model('DemoLiteModel')
        ..table('test')
        ..inheritAllFromBase()
        ..addFields({
          'description': Field<String?>('description'),
        }),
    ];
  }
}
