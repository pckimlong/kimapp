import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:kimapp/kimapp.dart';
import 'package:recase/recase.dart';
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
    if (element is! ClassElement) return;

    final buildMethod = element.methods.firstWhereOrNull((method) => method.name == "build");
    if (buildMethod == null) {
      // Only stateful provider contain build method can generate form
      return;
    }

    final returnType = buildMethod.returnType;
    if (returnType is! ClassElement || returnType.element == null) {
      // Return type of build method must be a class
      return;
    }

    final classElement = returnType.element!;
    if (classElement is! ClassElement || !providerStatusClassType.isAssignableFrom(classElement)) {
      // Support only class with ProviderStatusClassMixin
      return;
    }

    // All valid start generate code...
    final providerClassName = element.thisType.toString();
    final familyParams = <String, String>{};
    final providerNameWithFamily = _providerFamilyParamBuilder(buildMethod.parameters);
    final fields = <String, String>{};

    // Generate family params
    for (final param in buildMethod.parameters) {
      final name = param.name;
      final type = param.type;
      familyParams[name] = type.toString();
    }

    // Generate form field
    for (final param in classElement.constructors) {
      // Don't generate status field because it from provider status mixin
      if (param.name != "status") {
        final name = param.name;
        final type = param.type.toString();
        fields[name] = type;
      }
    }

    final buffer = StringBuffer();

    // Generate helper mixin
    buffer.writeln(
      '/// Mixin use for update properties. You will need to add this mixin to provider in order to make it work',
    );

    buffer.writeln('');

    // Generate family provider relations
    if (familyParams.isNotEmpty) {
      buffer.write(_generateFamilyParamsClass(providerClassName, familyParams));
      buffer.writeln('');
      buffer.write(_generateFamilyFormWidget(providerClassName, familyParams));
    }

    buffer.writeln('');

    // Generate field widget
    for (final fieldName in fields.keys) {
      final fieldType = fields[fieldName]!;

      final fieldWidget = _generateFieldWidget(
        providerClassName: providerClassName,
        fieldName: fieldName,
        fieldType: fieldType,
        providerNameFamily: providerNameWithFamily,
        familyParams: familyParams,
      );
      buffer.write(fieldWidget);
    }

    return buffer.toString();
  }
}

String _dataType(String name, Map<String, String> source) {
  return source[name] as String;
}

String _providerFamilyParamBuilder(List<ParameterElement> params) {
  if (params.isEmpty) return "";

  return '''(
    ${params.map((e) {
    if (e.isPositional) {
      return "family.$e";
    } else {
      return "$e: family.$e";
    }
  }).join(',\n')}
  )''';
}

/// Child widget ----------------------

String _generateFieldWidget({
  required String providerClassName,
  required String fieldName,
  required String fieldType,
  required String providerNameFamily,
  required Map<String, String> familyParams,
}) {
  final result = """
    typedef $providerClassName${fieldName.pascalCase}ChildBuilder = Widget Function(
      WidgetRef ref,
      $fieldType $fieldName,
      void Function($fieldType new${fieldName.pascalCase}) change${fieldName.pascalCase},
      bool showValidation,
    );

    class $providerClassName${fieldName.pascalCase}FieldWidget extends HookConsumerWidget {
      const $providerClassName${fieldName.pascalCase}FieldWidget({super.key, required this.builder});
      final $providerClassName${fieldName.pascalCase}ChildBuilder builder;

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        ${_defineLocalFamily(providerClassName, familyParams)}
        final controller = ref.watch($providerNameFamily.notifier);
        final state = ref.watch($providerNameFamily.select((value) => value.$fieldName));
        final showValidation = ref.watch($providerNameFamily.select((value) => value.status.isFailure));
        return builder(ref, state, controller.on${fieldName.pascalCase}Changed, showValidation);
      }
    }
  """;

  return result;
}

/// Family ---------------------------
String _familyParamClassName(String providerName) {
  return "_${providerName}FamilyParam";
}

String _generateFamilyParamsClass(String providerName, Map<String, String> params) {
  if (params.isEmpty) return '';

  final name = _familyParamClassName(providerName);
  final props = params.keys;

  final result = '''
      class $name {
        ${props.map((e) => "final ${_dataType(e, params)} $e;").join('\n')}

        const $name({
          ${props.map((e) => "required this.$e").join(',\n')}
        });
      
        @override
        bool operator ==(covariant $name other) {
          if (identical(this, other)) return true;
      
          return ${props.map((e) => "other.$e == $e").join('\n\t\t&&')};
        }
      
        @override
        int get hashCode => a.hashCode ^ b.hashCode ^ user.hashCode;
      }
      ''';

  return result;
}

String _defineLocalFamily(String providerName, Map<String, String> param) {
  final props = param.keys;
  return '''
    final family = ${_familyParamClassName(providerName)}(
          ${props.map((e) => '$e:$e').join(',\n')}
        );
  ''';
}

String _familyProviderName(String providerName) {
  return '_${providerName.camelCase}FamilyParamProvider';
}

String _generateFamilyFormWidget(String providerName, Map<String, String> params) {
  if (params.isEmpty) return '';

  final props = params.keys;
  final result = """
    class ${providerName}FormWidget extends HookConsumerWidget {
      const ${providerName}FormWidget({
        super.key,
        ${props.map((e) => "required this.$e").join(',\n')}
        required this.child,
      });

      ${props.map((e) => "final ${_dataType(e, params)} $e;").join('\n')}
      final Widget child;

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        ${_defineLocalFamily(providerName, params)}

        return ProviderScope(
          overrides: [${_familyProviderName(providerName)}.overrideWithValue(family)],
          child: child,
        );
      }
    }

    // Family provider override --------------------------------------------------
    final ${_familyProviderName(providerName)} = Provider<${_familyParamClassName(providerName)}>((ref) {
      throw 'You need to add [${providerName}FormWidget] as your parent. This allow to internal override family provider param';
    });
  """;

  return result;
}
