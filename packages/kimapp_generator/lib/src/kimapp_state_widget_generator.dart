import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:kimapp/kimapp.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:source_gen/source_gen.dart';

const riverpodChecker = TypeChecker.fromRuntime(Riverpod);
const asyncValueChecker = TypeChecker.fromRuntime(AsyncValue);
const futureTypeChecker = TypeChecker.fromRuntime(Future);
const streamTypeChecker = TypeChecker.fromRuntime(Stream);
const iterableTypeChecker = TypeChecker.fromRuntime(Iterable);

class KimappStateWidgetGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final providers = library.annotatedWith(TypeChecker.fromRuntime(StateWidget));

    if (providers.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();
    buffer.writeln("// ignore_for_file: unused_import, depend_on_referenced_packages");

    final imports = _getSourceFileImports(library);

    final currentFilePath = buildStep.inputId.path;
    final currentFileName = path.basename(currentFilePath);
    imports.add("import '$currentFileName';");

    for (final provider in providers) {
      final element = provider.element;
      final providerType = _getProviderType(element);
      imports.addAll(_getReturnObjectImports(providerType));
    }

    // Add additional necessary imports
    imports.add("import 'package:flutter/widgets.dart';");
    imports.add("import 'package:flutter_riverpod/flutter_riverpod.dart';");

    buffer.writeln(imports.join('\n'));
    buffer.writeln();

    for (final provider in providers) {
      final element = provider.element;

      final providerType = _getProviderType(element);
      final baseReturnType = _getBaseReturnType(providerType);
      final isAsyncValue = _isAsyncValueType(providerType);

      _validateReturnType(baseReturnType);

      final fields = _getFields(isAsyncValue ? baseReturnType! : providerType);
      final isSingleValue = fields.isEmpty;
      final familyParams = _getFamilyParams(element);

      if (familyParams.isNotEmpty && !isSingleValue) {
        buffer.writeln(_generateDebugCheckFunction(element));
        buffer.writeln(_generateParamsProvider(element, familyParams));
      }

      buffer.writeln(_generateMainStateWidget(
          element, familyParams, isAsyncValue, baseReturnType!, isSingleValue));

      if (!isSingleValue) {
        buffer.writeln(
            _generateSubWidgets(element, fields, familyParams, isAsyncValue, isSingleValue));
      }

      buffer.writeln();
    }

    return buffer.toString();
  }

  Set<String> _getSourceFileImports(LibraryReader library) {
    final imports = Set<String>();
    for (var import in library.element.importedLibraries) {
      final uri = import.source.uri;
      String importStr = "import '${uri.toString()}';";

      // Avoid duplicating package imports
      if (!uri.isScheme('dart') &&
          !uri.toString().contains('package:flutter/') &&
          !uri.toString().contains('package:flutter_riverpod/') &&
          !uri.toString().contains('package:riverpod/') &&
          !uri.toString().contains('annotation/') &&
          !uri.toString().contains('package:kimapp/')) {
        imports.add(importStr);
      }
    }
    return imports;
  }

  void _validateReturnType(DartType? baseReturnType) {
    if (baseReturnType == null || baseReturnType is DynamicType || baseReturnType is VoidType) {
      throw InvalidGenerationSourceError(
        'The provider must have a non-void, non-dynamic return type.',
      );
    }
  }

  String _generateProviderSuffix(Map<String, Map<String, dynamic>> familyParams) {
    if (familyParams.isEmpty) return '';

    return '(${familyParams.entries.map((e) {
      final isNamedParam = e.value['is_named_param'] as bool;
      return isNamedParam ? '${e.key}: ${e.key}' : e.key;
    }).join(', ')})';
  }

  String _generateDebugCheckFunction(Element element) {
    final className = _getNameWithSuffix(element, "StateWidget");
    return '''
    bool _debugCheckHas$className(BuildContext context) {
      assert(() {
        if (context.widget is! $className &&
            context.findAncestorWidgetOfExactType<$className>() == null) {
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('No $className found'),
            ErrorDescription(
              '\${context.widget.runtimeType} widgets require a $className widget ancestor.',
            ),
          ]);
        }
        return true;
      }());
      return true;
    }
    ''';
  }

  String _generateParamsProvider(Element element, Map<String, Map<String, dynamic>> familyParams) {
    final className = _getNameWithSuffix(element, "ParamsProvider");
    return '''
    class _$className extends InheritedWidget {
      const _$className({
        ${familyParams.entries.map((e) => 'required this.${e.key},').join('\n        ')}
        required super.child,
      });

      ${familyParams.entries.map((e) => 'final ${e.value['type']} ${e.key};').join('\n      ')}

      static _$className? of(BuildContext context) {
        return context.dependOnInheritedWidgetOfExactType<_$className>();
      }

      @override
      bool updateShouldNotify(_$className oldWidget) {
        return ${familyParams.keys.map((k) => '$k != oldWidget.$k').join(' || ')};
      }
    }
    ''';
  }

  String _generateMainStateWidget(
    Element element,
    Map<String, Map<String, dynamic>> familyParams,
    bool isAsyncValue,
    DartType baseReturnType,
    bool isSingleValue,
  ) {
    final className = _getNameWithSuffix(element, "StateWidget");
    final providerName = _getProviderName(element).camelCase;
    final paramsProviderName = _getNameWithSuffix(element, "ParamsProvider");

    String generateConstructorParams({bool usingThis = false}) {
      if (familyParams.isEmpty) return '';

      return familyParams.entries.map((e) {
        final param = e.value;
        final isOptional = param['is_optional'] as bool;
        final defaultValue = param['default_value'];
        final type = param['type'] as String;

        if (isOptional && defaultValue != null && defaultValue != 'null') {
          return '${usingThis ? 'this.' : '$type'}${e.key} = $defaultValue,';
        } else if (isOptional) {
          return '${usingThis ? 'this.' : '$type'}? ${e.key},';
        } else {
          return 'required ${usingThis ? 'this.' : '$type'}${e.key},';
        }
      }).join('\n    ');
    }

    String generateFieldDeclarations() {
      if (familyParams.isEmpty) return '';

      return familyParams.entries.map((e) {
        final type = e.value['type'] as String;
        return 'final $type ${e.key};';
      }).join('\n  ');
    }

    String generateProviderCall() {
      if (familyParams.isEmpty) return '';

      return familyParams.keys.map((k) => '$k: $k').join(', ');
    }

    String assertString() {
      if (isSingleValue) return '';

      return ''' : assert(
          builder != null || child != null,
          'Either child or builder must be provided, but not both.',
        )''';
    }

    String builderString() {
      return '''Consumer(
            builder: (context, ref, _) {
              final state = ref.watch($providerName${_generateProviderSuffix(familyParams)});
              return builder${isSingleValue ? "" : "!"}(context, ref, state);
            },
          )''';
    }

    String withChild() {
      return '''final content = builder != null
        ? ${builderString()}
        : child!;

    ${familyParams.isNotEmpty ? 'return _$paramsProviderName(' : 'return '}
      ${familyParams.isNotEmpty ? generateProviderCall() + ',' : ''}
      ${familyParams.isNotEmpty ? 'child: content,' : 'content'}
    ${familyParams.isNotEmpty ? ');' : ';'}''';
    }

    return '''
    typedef ${className}Builder = Widget Function(
      BuildContext context,
      WidgetRef ref,
      ${isAsyncValue ? 'AsyncValue<${baseReturnType.getDisplayString(withNullability: true)}>' : _getProviderType(element).getDisplayString(withNullability: true)} state,
    );

    class $className extends StatelessWidget {
      const $className({
        super.key,
        ${generateConstructorParams(usingThis: true)}
        ${!isSingleValue ? 'this.child,' : ''}
        ${isSingleValue ? 'required' : ''} this.builder,
      })${assertString()};

      ${generateFieldDeclarations()}
      ${!isSingleValue ? 'final Widget? child;' : ''}
      ${isSingleValue ? 'final ${className}Builder builder;' : 'final ${className}Builder? builder;'}

      @override
      Widget build(BuildContext context) {
        ${isSingleValue ? 'return ${builderString()};' : withChild()}
      }
    }
    ''';
  }

  String _generateSubWidgets(
    Element element,
    Map<String, String> fields,
    Map<String, Map<String, dynamic>> familyParams,
    bool isAsyncValue,
    bool isSingleValue,
  ) {
    final className = _getNameWithSuffix(element, "StateWidget");
    final providerName = _getProviderName(element).camelCase;
    final buffer = StringBuffer();

    for (final field in fields.entries) {
      final fieldName = field.key.pascalCase;
      final fieldType = field.value;

      buffer.writeln('''
      typedef ${className}${fieldName}WidgetBuilder = Widget Function(
        BuildContext context,
        WidgetRef ref,
        ${isAsyncValue ? 'AsyncValue<$fieldType>' : fieldType} ${field.key},
      );

      class ${className}${fieldName}Widget extends StatelessWidget {
        const ${className}${fieldName}Widget({
          super.key,
          required this.builder,
        });

        final ${className}${fieldName}WidgetBuilder builder;

        @override
        Widget build(BuildContext context) {
          ${!isSingleValue && familyParams.isNotEmpty ? 'assert(_debugCheckHas$className(context));' : ''}
          ${familyParams.isNotEmpty ? 'final param = _${_getNameWithSuffix(element, "ParamsProvider")}.of(context)!;' : ''}
          
          return Consumer(
            builder: (context, ref, child) {
              ${_generateParamFromFamilyParams(familyParams)}

              final state = ref.watch(
                $providerName${_generateProviderSuffix(familyParams)}.select((state) => state${isAsyncValue ? '.whenData((data) => data.${field.key})' : '.${field.key}'}),
              );
              return builder(context, ref, state);
            },
          );
        }
      }
      ''');
    }

    return buffer.toString();
  }

  String _generateParamFromFamilyParams(Map<String, Map<String, dynamic>> familyParams) {
    return familyParams.entries
        .map((e) => 'final ${e.value['type']} ${e.key} = param.${e.key};')
        .join('\n        ');
  }

  bool _isAsyncValueType(DartType type) {
    if (asyncValueChecker.isExactlyType(type)) {
      return true;
    }

    if (type is InterfaceType) {
      // Check if it's a Future
      if (futureTypeChecker.isAssignableFromType(type)) {
        return true;
      }

      // Check if it's a Stream
      if (streamTypeChecker.isAssignableFromType(type)) {
        return true;
      }

      // Check for FutureOr
      if (type.isDartAsyncFutureOr) {
        return true;
      }
    }

    return false;
  }

  DartType _getProviderType(Element element) {
    if (element is ClassElement) {
      final buildMethod = element.methods.firstWhereOrNull((method) => method.name == 'build');
      if (buildMethod != null) {
        return buildMethod.returnType;
      }
    } else if (element is FunctionElement) {
      return element.returnType;
    } else if (element is VariableElement) {
      return element.type;
    }
    throw InvalidGenerationSourceError(
      'Unable to determine provider type.',
      element: element,
    );
  }

  Set<String> _getReturnObjectImports(DartType providerType) {
    final libraries = Set<String>();

    void addLibrary(Element? element) {
      if (element != null) {
        libraries.add(element.library!.source.uri.toString());
      }
    }

    void processClassElement(ClassElement classElement) {
      addLibrary(classElement);

      final validFields = classElement.fields.where((field) => !field.isStatic && field.isPublic);
      if (validFields.isEmpty) {
        final constructors =
            classElement.constructors.where((c) => !c.isPrivate && c.parameters.isNotEmpty);
        for (final constructor in constructors) {
          for (final parameter in constructor.parameters) {
            addLibrary(parameter.type.element);
          }
        }
      } else {
        for (final field in validFields) {
          if (field.type.element is ClassElement) {
            addLibrary(field.type.element);
          }
        }
      }
    }

    if (providerType is ParameterizedType) {
      for (final typeArg in providerType.typeArguments) {
        if (typeArg.element is ClassElement) {
          processClassElement(typeArg.element as ClassElement);
        } else {
          addLibrary(typeArg.element);
        }
      }
    } else if (providerType.element is ClassElement) {
      processClassElement(providerType.element as ClassElement);
    }

    return libraries.map((e) => "import '$e';").toSet();
  }

  DartType? _getBaseReturnType(DartType providerType) {
    if (providerType is ParameterizedType && providerType.typeArguments.isNotEmpty) {
      return providerType.typeArguments.first;
    }
    return providerType;
  }

  Map<String, String> _getFields(DartType type) {
    if (type.element is ClassElement) {
      final classType = type.element as ClassElement;

      if (!classType.isPrivate &&
          !classType.library.isDartCore &&
          !iterableTypeChecker.isAssignableFrom(classType)) {
        final validConstructor = classType.constructors.firstWhereOrNull((c) => !c.isPrivate);
        if (validConstructor != null) {
          return {
            for (final parameter in validConstructor.parameters)
              parameter.name: parameter.type.getDisplayString(withNullability: true)
          };
        }
      }
    }

    return {};
  }

  Map<String, Map<String, dynamic>> _getFamilyParams(Element element) {
    if (element is ClassElement) {
      final buildMethod = element.methods.firstWhere((method) => method.name == 'build');
      return {
        for (final parameter in buildMethod.parameters)
          parameter.name: {
            "is_optional": parameter.isOptional,
            "default_value": parameter.defaultValueCode.toString(),
            "type": parameter.type.getDisplayString(withNullability: true),
            "is_named_param": parameter.isNamed,
          }
      };
    }

    if (element is FunctionElement) {
      return {
        // ignore first parameter
        for (var i = 1; i < element.parameters.length; i++)
          "${element.parameters[i].name}": {
            "is_optional": element.parameters[i].isOptional,
            "default_value": element.parameters[i].defaultValueCode.toString(),
            "type": element.parameters[i].type.getDisplayString(withNullability: true),
            "is_named_param": element.parameters[i].isNamed,
          }
      };
    }

    return {};
  }

  String _getCapitalizedName(Element element) => element.name!.pascalCase;
  String _getNameWithSuffix(Element element, [String suffix = "Provider"]) =>
      "${_getCapitalizedName(element)}$suffix";
  String _getProviderName(Element element) => _getNameWithSuffix(element, "Provider");
}
