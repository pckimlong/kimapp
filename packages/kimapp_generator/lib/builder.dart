import 'package:build/build.dart';
import 'package:kimapp_generator/src/kimapp_form_generator.dart';
import 'package:kimapp_generator/src/table_model_generator.dart';
import 'package:kimapp_generator/src/table_structure_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'src/kimapp_state_widget_generator.dart';

/// Create separate generator because I need to make this table run before json serializable
Builder kimappTableGenerator(BuilderOptions options) =>
    LibraryBuilder(TableStructureGenerator(), generatedExtension: '.table.dart');

Builder kimappModelGenerator(BuilderOptions options) =>
    SharedPartBuilder([TableModelGenerator()], 'kimapp_generator');

Builder kimappFormGenerator(BuilderOptions options) =>
    SharedPartBuilder([KimappFormGenerator()], 'kimapp_form_generator');

Builder kimappStateWidgetGenerator(BuilderOptions options) =>
    SharedPartBuilder([KimappStateWidgetGenerator()], 'kimapp_state_widget_generator');