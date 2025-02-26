import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType, TargetKind.function})
@sealed
class FormWidget {
  const FormWidget();
}

const formWidget = FormWidget();

@Target({TargetKind.classType, TargetKind.function})
@sealed
class FormUpdateWidget {
  const FormUpdateWidget();
}

const formUpdateWidget = FormUpdateWidget();

@Target({TargetKind.classType, TargetKind.function})
@sealed
class StateWidget {
  const StateWidget();
}

const stateWidget = StateWidget();
