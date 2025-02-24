import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:kimapp/kimapp.dart';
import 'package:recase/recase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:source_gen/source_gen.dart';

const riverpodChecker = TypeChecker.fromRuntime(Riverpod);
const asyncValueChecker = TypeChecker.fromRuntime(AsyncValue);
const futureTypeChecker = TypeChecker.fromRuntime(Future);
const streamTypeChecker = TypeChecker.fromRuntime(Stream);
const iterableTypeChecker = TypeChecker.fromRuntime(Iterable);

class KimappStateWidgetGenerator extends GeneratorForAnnotation<StateWidget> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();

    final providerType = _getProviderType(element);
    final baseReturnType = _getBaseReturnType(providerType);
    final isAsyncValue = _isAsyncValueType(providerType);

    _validateReturnType(baseReturnType);

    final familyParams = _getFamilyParams(element);

    buffer.writeln(_generateProviderWidget(element, familyParams, isAsyncValue, baseReturnType!));

    if (familyParams.isNotEmpty) {
      buffer.writeln(_generateDebugCheckFunction(element));
      buffer.writeln(_generateParamsProvider(element, familyParams));
    }

    buffer.writeln(_generateStateWidget(element, familyParams, isAsyncValue, baseReturnType));
    buffer.writeln(_generateStateSelectWidget(element, familyParams, isAsyncValue, baseReturnType));

    // return "/*\n" + buffer.toString() + "\n*/";
    return buffer.toString();
  }

  String _getCapitalizedName(Element element) => element.name!.pascalCase;
  String _getNameWithSuffix(Element element, [String suffix = "Provider"]) =>
      "${_getCapitalizedName(element)}$suffix";
  String _getProviderName(Element element) => _getNameWithSuffix(element, "Provider");

  /// ==================================================
  /// Generate code
  /// ==================================================

  String _generateProviderWidget(
    Element element,
    Map<String, Map<String, dynamic>> familyParams,
    bool isAsyncValue,
    DartType baseReturnType,
  ) {
    final className = _getNameWithSuffix(element, "ProviderWidget");
    final providerName = _getProviderName(element).camelCase;
    final paramsProviderName = _getNameWithSuffix(element, "ParamsProvider");
    final returnTypeStr = isAsyncValue
        ? 'AsyncValue<${baseReturnType.getDisplayString(withNullability: true)}>'
        : _getProviderType(element).getDisplayString(withNullability: true);

    String generateConstructorParams({bool usingThis = false}) {
      if (familyParams.isEmpty) return '';

      return familyParams.entries.map((e) {
        final param = e.value;
        final isOptional = param['is_optional'] as bool;
        final defaultValue = param['default_value'];

        if (isOptional && defaultValue != null && defaultValue != 'null') {
          return '${usingThis ? 'this.' : ''}${e.key} = $defaultValue,';
        } else if (isOptional) {
          return '${usingThis ? 'this.' : ''}${e.key},';
        } else {
          return 'required ${usingThis ? 'this.' : ''}${e.key},';
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
      return familyParams.entries.map((e) {
        final isNamed = e.value['is_named_param'] as bool;
        if (isNamed) {
          return '${e.key}: ${e.key}';
        } else {
          return e.key;
        }
      }).join(', ');
    }

    return '''
    /// A widget that provides access to the state of ${element.name}.
    ///
    /// This widget serves as a provider for state management and must be an ancestor
    /// of any widgets that need to access the state. It offers flexible state handling
    /// through various callback options:
    ///
    /// * [builder] - A callback that provides complete control over widget building
    /// * [child] - A default widget to display when no specific builder logic is needed
    ${isAsyncValue ? '''///
    /// For asynchronous states, additional callbacks are available:
    /// * [loading] - Custom widget for loading state
    /// * [error] - Custom widget for error state
    /// * [data] - Custom widget for data state
    ///
    /// This widget integrates with [KimappThemeExtension] to provide default loading
    /// and error widgets. To use this functionality:
    ///
    /// 1. Add kimapp_utils to your pubspec.yaml:
    /// ```yaml
    /// dependencies:
    ///   kimapp_utils: ^latest_version
    /// ```
    ///
    /// 2. Configure KimappThemeExtension in your app theme:
    /// ```dart
    /// MaterialApp(
    ///   theme: ThemeData(
    ///     extensions: [
    ///       KimappThemeExtension(
    ///         defaultLoadingStateWidget: (context, ref) => const CircularProgressIndicator(),
    ///         defaultErrorStateWidget: (context, ref, error) => Text(error.toString()),
    ///       ),
    ///     ],
    ///   ),
    /// )
    /// ```''' : ''}
    ///
    /// Example usage:
    /// ```dart
    /// $className(
    ///   ${familyParams.entries.map((e) => '${e.key}: ${e.key},').join('\n    /// ')}
    ///   builder: (context, ref, state, child) {
    ///     return Text(state.toString());
    ///   },${isAsyncValue ? '''
    ///   loading: () => const CircularProgressIndicator(),
    ///   error: (error, stack) => Text('Error: \$error'),
    ///   data: (data) => Text(data.toString()),''' : ''}
    ///   child: const Text('Default Content'),
    /// )
    /// ```
    ///
    /// See also:
    /// * [${_getNameWithSuffix(element, "StateWidget")}] - For direct state access
    /// * [${_getNameWithSuffix(element, "StateSelectWidget")}] - For optimized state selection
    class $className extends StatelessWidget {
      const $className({
        super.key,
        ${generateConstructorParams(usingThis: true)}
        this.child,${isAsyncValue ? '''\nthis.loading,\nthis.error,\nthis.data,''' : ''}
        this.builder,
      });

      ${generateFieldDeclarations()}
      final Widget? child;${isAsyncValue ? '''\nfinal Widget Function()? loading;\nfinal Widget Function(Object error, StackTrace? stackTrace)? error;\nfinal Widget Function($baseReturnType data)? data;''' : ''}
      final Widget Function(
        BuildContext context,
        WidgetRef ref,
        $returnTypeStr state,
        Widget? child,
      )? builder;

      @override
      Widget build(BuildContext context) {
        
        return ${familyParams.isNotEmpty ? '_$paramsProviderName(' : ''}
          ${familyParams.entries.map((e) => '${e.key}: ${e.key},').join('\n')}
          ${familyParams.isNotEmpty ? 'child:' : ''}
          Consumer(
            child: child,
            builder: (context, ref, child) {
              final state = ref.watch($providerName${familyParams.isEmpty ? '' : '(${generateProviderCall()})'});

              if (builder != null) {
                return builder!(context, ref, state, child);
              }

              ${isAsyncValue ? '''
              final themeExtension = Theme.of(context).extension<KimappThemeExtension>();
              return state.when(
                data: (data) {
                  final result = this.data?.call(data) ?? child;
                  if (result == null) {
                    Kimapp.instance.log(LoggerType.warning, message: 'No child provided for ${element.name}ProviderWidget. Empty SizedBox will be returned.');
                    return const SizedBox.shrink();
                  }
                  return result;
                },
                error: (error, stack) =>
                    this.error?.call(error, stack) ?? 
                    themeExtension?.defaultErrorStateWidget?.call(context, ref, error) ??
                    const SizedBox.shrink(),
                loading: () => loading?.call() ?? 
                    themeExtension?.defaultLoadingStateWidget?.call(context, ref) ??
                    const SizedBox.shrink(),
              );
              ''' : 'return child ?? const SizedBox.shrink();'}
            },
          )${familyParams.isNotEmpty ? ')' : ''};
      }
    }
    ''';
  }

  String _generateStateWidget(
    Element element,
    Map<String, Map<String, dynamic>> familyParams,
    bool isAsyncValue,
    DartType baseReturnType,
  ) {
    final className = _getNameWithSuffix(element, "StateWidget");
    final providerName = _getProviderName(element).camelCase;
    final paramsProviderName = _getNameWithSuffix(element, "ParamsProvider");

    String generateParamsRecord() {
      if (familyParams.isEmpty) return '';
      final params = familyParams.entries.map((e) => '${e.value['type']} ${e.key}').join(', ');
      return '({$params})';
    }

    String generateBuilderParams() {
      final List<String> params = [
        'BuildContext context',
        'WidgetRef ref',
      ];

      if (familyParams.isNotEmpty) {
        params.add('${generateParamsRecord()} params');
      }

      params.add('${baseReturnType.getDisplayString(withNullability: true)} state');
      params.add('Widget? child');

      return params.join(',\n    ');
    }

    String generateProviderParams() {
      if (familyParams.isEmpty) return '';
      return familyParams.entries.map((e) {
        final isNamed = e.value['is_named_param'] as bool;
        if (isNamed) {
          return '${e.key}: params!.${e.key}';
        } else {
          return 'params!.${e.key}';
        }
      }).join(', ');
    }

    String generateRecordParams() {
      if (familyParams.isEmpty) return '';
      return familyParams.entries.map((e) => '${e.key}: params.${e.key}').join(', ');
    }

    return '''
    /// A widget that provides direct access to the ${element.name} state.
    ///
    /// This widget requires a [${_getNameWithSuffix(element, "ProviderWidget")}] ancestor
    /// and provides a more streamlined way to build UI based on the current state.
    /// Unlike the provider widget, this widget assumes the state is available and
    /// ready to use.
    ///
    /// Key features:
    /// * Direct state access through the [builder] callback
    /// * Automatic state updates when the underlying data changes
    /// * Type-safe state handling
    ${familyParams.isNotEmpty ? '''///
    /// This widget automatically inherits family parameters from its provider ancestor,
    /// making it convenient to use in nested widget structures.''' : ''}
    ///
    /// Example usage:
    /// ```dart
    /// $className(
    ///   builder: (context, ref${familyParams.isNotEmpty ? ', params' : ''}, state, child) {
    ///     return Text(state.toString());
    ///   },
    ///   child: const Text('Optional child widget'),
    /// )
    /// ```
    class $className extends ConsumerWidget {
      const $className({
        super.key,
        required this.builder,
        this.child,
      });

      final Widget Function(
        ${generateBuilderParams()}
      ) builder;
      final Widget? child;

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        ${familyParams.isNotEmpty ? '_debugCheckHas${_getNameWithSuffix(element, "ProviderWidget")}(context);' : ''}

        ${familyParams.isNotEmpty ? '''
        final params = _$paramsProviderName.of(context);
        final state = ref.watch($providerName(${generateProviderParams()}))${isAsyncValue ? '.requireValue' : ''};
        return builder(
          context,
          ref,
          (${generateRecordParams()}),
          state,
          child,
        );
        ''' : '''
        final state = ref.watch($providerName)${isAsyncValue ? '.requireValue' : ''};
        return builder(context, ref, state, child);
        '''}
      }
    }
    ''';
  }

  String _generateStateSelectWidget(
    Element element,
    Map<String, Map<String, dynamic>> familyParams,
    bool isAsyncValue,
    DartType baseReturnType,
  ) {
    final className = _getNameWithSuffix(element, "StateSelectWidget");
    final providerName = _getProviderName(element).camelCase;
    final paramsProviderName = _getNameWithSuffix(element, "ParamsProvider");

    String generateParamsRecord() {
      if (familyParams.isEmpty) return '';
      final params = familyParams.entries.map((e) => '${e.value['type']} ${e.key}').join(', ');
      return '({$params})';
    }

    String generateBuilderParams() {
      final List<String> params = [
        'BuildContext context',
        'WidgetRef ref',
      ];

      if (familyParams.isNotEmpty) {
        params.add('${generateParamsRecord()} params');
      }

      params.add('Selected value');
      params.add('Widget? child');

      return params.join(',\n    ');
    }

    String generateProviderParams() {
      if (familyParams.isEmpty) return '';
      return familyParams.entries.map((e) {
        final isNamed = e.value['is_named_param'] as bool;
        return isNamed ? '${e.key}: params!.${e.key}' : 'params!.${e.key}';
      }).join(', ');
    }

    String generateRecordParams() {
      if (familyParams.isEmpty) return '';
      return familyParams.entries.map((e) => '${e.key}: params.${e.key}').join(', ');
    }

    return '''
    /// A widget that provides optimized access to a selected portion of the ${element.name} state.
    ///
    /// This widget enables efficient state management by:
    /// * Selecting and watching specific parts of the state using [selector]
    /// * Rebuilding only when the selected value changes
    /// * Providing type-safe access to the selected state portion
    ///
    /// Key benefits:
    /// * Improved performance through selective rebuilds
    /// * Clean separation of state selection and UI logic
    /// * Type-safe state handling with generics support
    ///
    /// Note: Requires a [${_getNameWithSuffix(element, "ProviderWidget")}] ancestor to function.
    ${familyParams.isNotEmpty ? '''///
    /// Family parameters are automatically inherited from the provider ancestor.''' : ''}
    ///
    /// Example usage:
    /// ```dart
    /// $className<String>(
    ///   selector: (state) => state.specificField,
    ///   builder: (context, ref${familyParams.isNotEmpty ? ', params' : ''}, selected, child) {
    ///     return Text(selected);
    ///   },
    /// )
    /// ```
    ///
    /// See also:
    /// * [${_getNameWithSuffix(element, "ProviderWidget")}] - The required provider widget
    /// * [${_getNameWithSuffix(element, "StateWidget")}] - For direct state access
    class $className<Selected> extends ConsumerWidget {
      const $className({
        super.key,
        required this.selector,
        required this.builder,
        this.child,
      });

      final Selected Function(${baseReturnType.getDisplayString(withNullability: true)} state) selector;
      final Widget Function(
        ${generateBuilderParams()}
      ) builder;
      final Widget? child;

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        ${familyParams.isNotEmpty ? '_debugCheckHas${_getNameWithSuffix(element, "ProviderWidget")}(context);' : ''}

        ${familyParams.isNotEmpty ? '''
        final params = _$paramsProviderName.of(context);
        final selected = ref.watch(
          $providerName(${generateProviderParams()})
            .select((value) => selector(${isAsyncValue ? 'value.requireValue' : 'value'})),
        );
        
        return builder(
          context,
          ref,
          (${generateRecordParams()}),
          selected,
          child,
        );
        ''' : '''
        final selected = ref.watch(
          $providerName.select((value) => selector(${isAsyncValue ? 'value.requireValue' : 'value'})),
        );
        
        return builder(context, ref, selected, child);
        '''}
      }
    }
    ''';
  }

  String _generateParamsProvider(Element element, Map<String, Map<String, dynamic>> familyParams) {
    final className = _getNameWithSuffix(element, "ParamsProvider");
    return '''
    /// An internal InheritedWidget that manages family parameters for ${element.name} widgets.
    ///
    /// This widget is used internally by the generated widgets to propagate family parameters
    /// down the widget tree. It should not be used directly in application code.
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

  String _generateDebugCheckFunction(Element element) {
    final className = _getNameWithSuffix(element, "ProviderWidget");
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

  DartType _getProviderType(Element element) {
    if (element is ClassElement) {
      final buildMethod = element.methods.firstWhere((method) => method.name == 'build');
      return buildMethod.returnType;
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

  DartType? _getBaseReturnType(DartType providerType) {
    if (providerType is ParameterizedType && providerType.typeArguments.isNotEmpty) {
      return providerType.typeArguments.first;
    }
    return providerType;
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

  void _validateReturnType(DartType? baseReturnType) {
    if (baseReturnType == null || baseReturnType is DynamicType || baseReturnType is VoidType) {
      throw InvalidGenerationSourceError(
        'The provider must have a non-void, non-dynamic return type.',
      );
    }
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
}
