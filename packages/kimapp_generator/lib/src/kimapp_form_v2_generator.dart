import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:kimapp/kimapp.dart';
import 'package:kimapp_generator/src/utils/consumer_widget.dart';
import 'package:kimapp_generator/src/utils/field_defination.dart';
import 'package:source_gen/source_gen.dart';

const providerStatusClassType = TypeChecker.fromRuntime(ProviderStatusClassMixin);
const formUpdateMixin = TypeChecker.fromRuntime(UpdateFormMixin);

/// Generate form v2 code. To make old form code still compatible with new update.
/// I want to make another generator to generate form v2 code.
/// this to ovoid migrate old hundreds of projects which use form v1.
class KimappFormV2Generator extends GeneratorForAnnotation<KimappFormV2> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return;

    final name = FieldDefination(
      name: 'name',
      type: 'String',
      defaultValue: null,
      isOptional: false,
    );

    // ProviderExtendedRef as private
    final result = generateConsumerWidget(
      name: 'TestingWidget',
      fields: {
        name,
      },
      build: 'return Container();',
    );

    // return "/* $result */";
    return '// hello';
  }
}
