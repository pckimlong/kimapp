import 'package:kimapp/kimapp.dart';

@Schema(tableName: 'others', className: 'Other', baseModelName: 'OtherModel')
class OtherSchema extends KimappSchema {
  OtherSchema._();

  final id = Field.id<int>('id').generateAs('OtherId');
  final name = Field<String>('name');
}
