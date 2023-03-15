import 'package:build/build.dart';
import 'package:kimapp_generator/src/kimapp_form_generator.dart';
import 'package:kimapp_generator/src/table_model_generator.dart';
import 'package:kimapp_generator/src/table_structure_generator.dart';

import 'package:source_gen/source_gen.dart';

/// Create separate generator because I need to make this table run before json serializable
Builder kimappTableGenerator(BuilderOptions options) =>
    LibraryBuilder(TableStructureGenerator(), generatedExtension: '.table.dart');

Builder kimappGenerator(BuilderOptions options) =>
    SharedPartBuilder([TableModelGenerator(), KimappFormGenerator()], 'kimapp_generator');
