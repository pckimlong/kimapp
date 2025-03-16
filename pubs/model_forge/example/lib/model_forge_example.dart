import 'package:example/model_forge.forge.dart';

class $DemoModel {
  final DemoId id;
  final String? name;

  const $DemoModel({required this.id, required this.name});

  int get sum => id.value + (name?.length ?? 0);
}

void main() {
  final demo = DemoModel(id: DemoId(value: 1), name: 'test');
  DemoModel.selectColumns;
  print(demo.toJson());
}
