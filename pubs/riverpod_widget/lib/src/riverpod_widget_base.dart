import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// Base class for all widget annotations
@Target({TargetKind.classType, TargetKind.function})
@sealed
abstract class WidgetAnnotation {
  const WidgetAnnotation();
}

@Target({TargetKind.classType, TargetKind.function})
@sealed
class FormWidget extends WidgetAnnotation {
  const FormWidget();
}

const formWidget = FormWidget();

@Target({TargetKind.classType, TargetKind.function})
@sealed
class FormUpdateWidget extends WidgetAnnotation {
  const FormUpdateWidget();
}

const formUpdateWidget = FormUpdateWidget();

@Target({TargetKind.classType, TargetKind.function})
@sealed
class StateWidget extends WidgetAnnotation {
  const StateWidget();
}

const stateWidget = StateWidget();
