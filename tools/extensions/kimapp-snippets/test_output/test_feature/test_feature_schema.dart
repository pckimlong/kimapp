import 'package:kimapp/kimapp.dart';

@Schema(
  tableName: 'test_features',
  className: 'TestFeature',
  baseModelName: 'TestFeatureModel',
)
class TestFeatureSchema extends KimappSchema {
  final id = Field.id<int>('id').generateAs('TestFeatureId');
  final name = Field<String>('name');

  @override
  List<Model> get models {
    return [
      Model('TestFeatureLiteModel')
        ..table()
        ..addFields({'id': id, 'name': name}),
      Model('TestFeatureDetailModel')
        ..table()
        ..inheritAllFromBase()
        ..addFields({
          'createdAt': Field<DateTime>('created_at'),
        }),

      // Params
      Model('TestFeatureCreateParam')..addFields({}),
      Model('TestFeatureUpdateParam')..addFields({}),
    ];
  }
}
