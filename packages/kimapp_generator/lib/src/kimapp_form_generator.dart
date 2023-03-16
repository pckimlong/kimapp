import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:kimapp/kimapp.dart';
import 'package:recase/recase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:source_gen/source_gen.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

const providerStatusClassType = TypeChecker.fromRuntime(ProviderStatusClassMixin);
const formUpdateMixin = TypeChecker.fromRuntime(UpdateFormMixin);

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
      return;
    }

    final classElement = returnType.element! as ClassElement;
    if (!providerStatusClassType.isAssignableFrom(classElement)) {
      // Support only class with ProviderStatusClassMixin
      return;
    }

    // All valid start generate code...
    final isFormUpdateType = formUpdateMixin.isAssignableFrom(classElement);
    final providerClassName = element.thisType.toString();
    final familyParams = <String, String>{};
    final providerNameWithFamily =
        _providerFamilyParamBuilder(providerClassName, buildMethod.parameters);
    final fields = <String, String>{};

    // Generate call method detail
    final callMethod = element.methods.firstWhereOrNull((method) => method.name == "call");
    if (callMethod == null) {
      print('[FORM GENERATOR FAILED] $classElement required [call] method');
      return;
    }

    // Generate family params
    for (final param in buildMethod.parameters) {
      final name = param.name;
      final type = param.type;
      familyParams[name] = type.toString();
    }

    final classConstructor = classElement.constructors.firstWhereOrNull((c) => !c.isPrivate);

    if (classConstructor == null) {
      print('[FORM GENERATOR FAILED] $classElement has no constructor');
      print(
        '[FORM GENERATOR FAILED] $classElement has following constructors: ${classElement.constructors.map((e) => e.getDisplayString(withNullability: true))}',
      );
      return;
    }

    if (classConstructor.parameters.isEmpty) {
      print('[FORM GENERATOR FAILED] $classConstructor has no parameters');
      return;
    }

    final callMethodApparent = callMethod.getDisplayString(withNullability: true);
    late final String providerStatusType;

    // Generate form field
    for (final param in classConstructor.parameters) {
      // Don't generate status field because it from provider status mixin
      if (param.name != "status") {
        if (!isFormUpdateType || (isFormUpdateType && param.name != "initialLoaded")) {
          final name = param.name;
          final type = param.type.toString();
          fields[name] = type;
        }
      } else {
        providerStatusType = param.type.toString();
      }
    }

    final buffer = StringBuffer();

    // Generate helper mixin
    buffer.writeln(
      '/// Mixin use for update properties. You will need to add this mixin to provider in order to make it work',
    );
    buffer.write(_generateMixin(
      providerClassName: providerClassName,
      fields: fields,
      isFormUpdateType: isFormUpdateType,
      buildMethodReturnType: classElement.name,
      providerStatusType: providerStatusType,
      callMethod: callMethodApparent,
    ));

    buffer.writeln('');

    // Generate family provider relations
    if (familyParams.isNotEmpty) {
      buffer.write(_generateFamilyParamsClass(providerClassName, familyParams));
      buffer.writeln('');
      buffer.write(
        _generateFormWidget(
          providerClassName: providerClassName,
          providerNameFamily: providerNameWithFamily,
          familyParams: familyParams,
        ),
      );
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

    return "/*\n$buffer\n*/";
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
  required bool isFormUpdateType,
  required String buildMethodReturnType,
  required String providerStatusType,
  required String callMethod,
}) {
  final names = fields.keys;

  final result = """
    mixin _\$${providerClassName}Form on _\$$providerClassName {
      ${isFormUpdateType ? """
      /// Initialize state for update form either by [local] or perform any fetch
      ///
      /// When finished it will update the [initialLoaded] flag to true. This mean any any call will ignore
      Future<$buildMethodReturnType> initState([$buildMethodReturnType? local]);

      Future<void> _initializeFormData([$buildMethodReturnType? local]) async {
        if (state.initialLoaded) return;
        final result = await initState(local);
        state = result.copyWith(initialLoaded: true);
      }
      """ : ""}

      $callMethod;

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
        ${_checkHasFormWidgetAssert(providerClassName)}
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

String _defineLocalFamilyOrEmpty(String providerName, Map<String, String> param) {
  final props = param.keys;
  if (props.isEmpty) return "";
  return '''
    final family = ${_familyParamClassName(providerName)}(
          ${props.map((e) => '$e:$e').join(',\n\t\t\t')}
        );
  ''';
}

String _familyProviderName(String providerName) {
  return '_${providerName.camelCase}FamilyParamProvider';
}

String _checkHasFormWidgetAssert(String providerClassName) {
  return "assert(_debugCheckHas${providerClassName}FormWidget(context));";
}

String _generateFormWidget({
  required String providerClassName,
  required String providerNameFamily,
  required Map<String, String> familyParams,
}) {
  final props = familyParams.keys;
  final result = """
    bool _debugCheckHas${providerClassName}FormWidget(BuildContext context) {
      assert(() {
        if (context.widget is! ${providerClassName}FormWidget && context.findAncestorWidgetOfExactType<${providerClassName}FormWidget>() == null) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('No ${providerClassName}FormWidget found'),
            ErrorDescription('\${context.widget.runtimeType} widgets require a ${providerClassName}FormWidget widget ancestor.'),
          ]);
        }
        return true;
      }());
      return true;
    }


    typedef ${providerClassName}FormChildBuilder = Widget Function(
      WidgetRef ref,
      ProviderStatus<int> status,
      bool isProgressing,
      Failure? failure,
      Future<ProviderStatus<int>> Function() submit,
    );

    /// Base form widget for [$providerClassName] provider
    /// 
    /// It required to add this as parent widget of fields widget if [$providerClassName] is a family provider 
    /// , otherwise it's optional
    class ${providerClassName}FormWidget extends HookConsumerWidget {
      const ${providerClassName}FormWidget({
        super.key,
        ${props.map((e) => "required this.$e,").join('\n\t\t\t\t')}
        required this.builder,
      });

      ${props.map((e) => "final ${_dataType(e, familyParams)} $e;").join('\n\t\t\t')}
      final ${providerClassName}FormChildBuilder builder;

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        ${_defineLocalFamilyOrEmpty(providerClassName, familyParams)}
        final status = ref.watch($providerNameFamily.select((value) => value.status));
        final isProgressing = status.isInProgress;
        final failure = status.failure;
        final controller = ref.watch($providerNameFamily.notifier);


        ${props.isNotEmpty ? """
          return ProviderScope(
          overrides: [${_familyProviderName(providerClassName)}.overrideWithValue(family)],
          child: builder(
            ref,
            isProgressing,
            failure,
            controller.call,
            ),
        );
        """ : """
          return: builder(
            ref,
            isProgressing,
            failure,
            controller.call,
            );
        """}
      }
    }
    
    ${props.isNotEmpty ? """
      // Family provider override --------------------------------------------------
      final ${_familyProviderName(providerClassName)} = Provider<${_familyParamClassName(providerClassName)}>((ref) {
        throw 'You need to add [${providerClassName}FormWidget] as your parent. This allow to internal override family provider param';
      });
    """ : ""}
  """;

  return result;
}
