import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_state_widget_example.g.dart';

@riverpod
@stateWidget
String myName(Ref ref) {
  return 'Pc Kimlong';
}

@stateWidget
@riverpod
class MyNameForm extends _$MyNameForm {
  @override
  FutureOr<String> build() {
    return 'Pc Kimlong';
  }
}
