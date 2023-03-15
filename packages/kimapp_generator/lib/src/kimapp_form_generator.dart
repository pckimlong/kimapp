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
    if (returnType.element is! ClassElement || returnType.element == null) {
      // print(
      //     '[FORM GENERATOR FAILED] $element build method return type [$returnType] is not valid for form generator');
      // Return type of build method must be a class
      return;
    }

    final classElement = returnType.element! as ClassElement;
    if (!providerStatusClassType.isAssignableFrom(classElement)) {
      // Support only class with ProviderStatusClassMixin
      return;
    }

    // All valid start generate code...
    final providerClassName = element.thisType.toString();
    final familyParams = <String, String>{};
    final providerNameWithFamily =
        _providerFamilyParamBuilder(providerClassName, buildMethod.parameters);
    final fields = <String, String>{};

    // Generate family params
    for (final param in buildMethod.parameters) {
      final name = param.name;
      final type = param.type;
      familyParams[name] = type.toString();
    }

    final classConstructor = classElement.constructors.firstOrNull;

    if (classConstructor == null) {
      print('[FORM GENERATOR FAILED] $classElement has no constructor');
      return;
    }

    // Generate form field
    for (final param in classConstructor.parameters) {
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
    buffer.write(_generateMixin(providerClassName: providerClassName, fields: fields));

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

String _providerFamilyParamBuilder(String providerClassName, List<ParameterElement> params) {
  final providerName = "${providerClassName.camelCase}Provider";

  if (params.isEmpty) return providerName;

  return '''$providerName(
     ${params.mapIndexed((i, param) {
    final name = param.name;
    final isNameVar = !param.isPositional;

    if (isNameVar) {
      return "$name: family.$name";
    } else {
      return "family.$name";
    }
  }).join(',\n')}
  )''';
}

// Mixin -------
String _generateMixin({
  required String providerClassName,
  required Map<String, String> fields,
}) {
  if (fields.isEmpty) return "";

  final names = fields.keys;

  final result = """
    mixin _\$${providerClassName}Form on _\$$providerClassName {
      ${names.map((name) {
    final type = fields[name]!;
    return "void on${name.pascalCase}Changed($type new${name.pascalCase}) => state = state.copyWith($name: new${name.pascalCase});";
  }).join('\n')}
    }
  """;

  return result;
}

// Child widget ----------------------

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
        ${familyParams.isNotEmpty ? "final family = ref.watch(${_familyProviderName(providerClassName)});" : ""}
        final controller = ref.watch($providerNameFamily.notifier);
        final state = ref.watch($providerNameFamily.select((value) => value.$fieldName));
        final showValidation = ref.watch($providerNameFamily.select((value) => value.status.isFailure));
        return builder(ref, state, controller.on${fieldName.pascalCase}Changed, showValidation,);
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
        int get hashCode => ${props.map((e) => "$e.hashCode").join('^')};
      }
      ''';

  return result;
}

String _defineLocalFamily(String providerName, Map<String, String> param) {
  final props = param.keys;
  return '''
    final family = ${_familyParamClassName(providerName)}(
          ${props.map((e) => '$e:$e').join(',\n\t\t\t')}
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
        ${props.map((e) => "required this.$e,").join('\n\t\t\t\t')}
        required this.child,
      });

      ${props.map((e) => "final ${_dataType(e, params)} $e;").join('\n\t\t\t')}
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
