import 'package:example/other_schema.schema.dart';
import 'package:kimapp/kimapp.dart';

@Schema(tableName: 'demos', className: 'Demo', baseModelName: 'DemoModel')
class Demo extends KimappSchema {
  final id = Field.id<int>('id').generateAs('DemoId');
  final name = Field<String?>('name');
  final description = Field<String?>('description');
  final age = Field<int>('age');
  final birthdate = Field<DateTime?>('birthdate');
  final address = Field<String?>('address');
  final other = Field.join<OtherModel?>().withForeignKey('other_id');

  @override
  List<Model> get models {
    return [
      Model('DemoDetailModel')
        ..table('v_demo_detail')
        ..addFields({
          'id': id,
          'name': name,
        }),
      Model('DemoLiteModel')
        ..table('test')
        ..inheritAllFromBase().addFields({
          'demoId': id,
          'description': Field<String?>('description'),
        }),
    ];
  }
}
