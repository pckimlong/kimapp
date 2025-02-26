import 'package:example/form_widget_v2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final state = ProviderContainer().read(actionClassProvider.notifier);
  state.updateAge(age);
}
