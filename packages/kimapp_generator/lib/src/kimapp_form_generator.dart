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
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || !providerStatusClassType.isSuperOf(element)) {
      /// Only support stateful provider which implement ProviderStatusClassMixin
      print(element);
      throw 'Not class';
    }

    // Get class name
    final className = element.thisType.toString();

    // Get build method
    final buildMethod = element.methods.firstWhereOrNull((method) => method.name == "build");
    if (buildMethod == null) {
      // If stateful provider has no build method, It mean it invalid
      return;
    }

    //
    return "$className $buildMethod";
  }
}
