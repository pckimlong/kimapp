import 'package:kimapp/annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'demo_schema.schema.dart';

part 'state_widget_example.g.dart';

@stateWidget
@riverpod
FutureOr<DemoModel> demo(DemoRef ref) {
  return DemoModel(
    id: DemoId.fromValue(1),
    age: 24,
    name: 'John',
    description: 'John Doe',
    address: '123 Main St',
    other: null,
  );
}
