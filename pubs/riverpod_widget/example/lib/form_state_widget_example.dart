import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_widget/riverpod_widget.dart';

part 'form_state_widget_example.g.dart';

@riverpod
@stateWidget
String myName(Ref ref) {
  return 'Kim';
}

@stateWidget
@riverpod
class MyNameForm extends _$MyNameForm {
  @override
  FutureOr<String> build() {
    return 'Pc Kimlong';
  }
}
