import 'package:kimapp/kimapp.dart';

@Schema(tableName: 'users', className: 'User', baseModelName: 'UserBaseModel')
class Demo extends KimappSchema {
  Demo._();

  final id = Field.id<int>('id').generateAs('DemoId');
  final name = Field<String>('name');
  final description = Field<String?>('description');
  final ignore = Field.ignore('filter_key');

  @override
  List<Model> get models {
    return [
      Model('UserDetailModel')
          .table('v_user_detail')
          .addFields({'id': id, 'name': name}).inheritAllFromBase(),
      Model('UserLiteModel')
        ..table('test')
        ..inheritAllFromBase()
        ..addFields({
          'description': Field<String?>('description'),
        }),
    ];
  }
}
