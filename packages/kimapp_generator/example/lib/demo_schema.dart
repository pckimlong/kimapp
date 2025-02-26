import 'package:example/other_schema.schema.dart';
import 'package:kimapp/kimapp.dart';

@Schema(
  tableName: 'demos',
  className: 'Demo',
  baseModelName: 'DemoModel',
)
class Demo extends KimappSchema {
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
        ..inheritAllFromBase()
        ..addFields({
          'name': name,
        }),
      Model('DemoLiteModel')..inheritAllFromBase(excepts: [description])
    ];
  }
}
