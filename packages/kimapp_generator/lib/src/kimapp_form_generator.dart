import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:source_gen/source_gen.dart';
// ignore: depend_on_referenced_packages

const providerStatusClassType = TypeChecker.fromRuntime(ProviderStatusClassMixin);

class KimappFormGenerator extends GeneratorForAnnotation<Riverpod> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
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
