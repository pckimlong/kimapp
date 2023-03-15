import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:source_gen/source_gen.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

const providerStatusClassType = TypeChecker.fromRuntime(ProviderStatusClassMixin);

class KimappFormGenerator extends GeneratorForAnnotation<Riverpod> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    print('------------------------------------------');
    print('If element is a class: ${element is ClassElement}');
    print('Element runtime type: ${element.runtimeType}');
    if (element is ClassElement) {
      print(
        'Element all super type: ${element.allSupertypes.map((e) => e.getDisplayString(withNullability: false))}',
      );
      print(
          'Element is extends providerStatusClassMixin ${providerStatusClassType.isAssignableFrom(element)}');

      print('Class element detail $element');
      print('Class element method ${element.methods.map((e) => e.name)}');
      print('Class element method return type ${element.methods.map((e) => e.returnType)}');

      final buildMethod = element.methods.firstWhereOrNull((element) => element.name == "build");
      print('build method $buildMethod');

      final buildReturnType = buildMethod?.returnType;
      print('build method return type $buildReturnType');
      print('build method returned type is a class ${buildReturnType is ClassElement}');
      print('build method return type ${buildReturnType?.element}');
      print('build method returned type is a class ${buildReturnType?.element is ClassElement}');
      if (buildReturnType?.element is ClassElement) {
        final c = buildReturnType?.element as ClassElement;
        print(
          'Super class of it is provider status ${providerStatusClassType.isAssignableFrom(c)}',
        );
        print(
            'Constructor: ${c.constructors.map((e) => e.getDisplayString(withNullability: true))}');
      }
    }

    // if (element is! ClassElement || !providerStatusClassType.isAssignableFrom(element)) {
    //   /// Only support stateful provider which implement ProviderStatusClassMixin
    //   print(element);
    //   throw 'Not class';
    // }

    // // Get class name
    // final className = element.thisType.toString();

    // // Get build method
    // final buildMethod = element.methods.firstWhereOrNull((method) => method.name == "build");
    // if (buildMethod == null) {
    //   // If stateful provider has no build method, It mean it invalid
    //   return;
    // }

    // //
    // return "$className $buildMethod";
    return "";
  }
}
