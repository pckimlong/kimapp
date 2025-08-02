/// Kimapp Schema Code Generator
///
/// This file contains the main generator that processes @Schema annotations and generates:
/// 1. Table classes - Static constants for table/column names (e.g., UserTable)
/// 2. ID classes - Type-safe identity wrappers (e.g., UserId extends Identity<int>)
/// 3. Base model classes - Freezed models with JSON serialization (e.g., UserBaseModel)
/// 4. Custom model classes - Additional models derived from schema (e.g., UserDetailModel)
///
/// Key Classes:
/// - KimappSchemaGenerator: Main generator entry point
/// - _ModelDefinition: Represents a model configuration from schema
/// - _FieldDefinition: Represents field metadata (normal, id, join, ignore types)
/// - _SchemaMetaData: Schema annotation data (tableName, className, baseModelName)
///
/// Generation Flow:
/// 1. Parse @Schema annotations from source files
/// 2. Extract field definitions from class members
/// 3. Parse model configurations from 'models' getter
/// 4. Generate table constants, ID classes, base models, and custom models
/// 5. Embed JSON keys directly in @JsonKey annotations (no static key constants)

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:kimapp/kimapp.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:source_gen/source_gen.dart';

class KimappSchemaGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final schemas = library.annotatedWith(TypeChecker.fromRuntime(Schema));
    if (schemas.isEmpty) return '';

    final buffer = StringBuffer();

    // First pass: collect all schema data for header
    final schemaData = <Map<String, dynamic>>[];
    for (var schema in schemas) {
      final annotation = schema.annotation;
      final schemaMetaData = _SchemaMetaData.fromAnnotation(annotation);
      final classElement = schema.element as ClassElement;
      final fields = await _getFields(buildStep, classElement);
      final models = await _getModels(buildStep, classElement, fields, schemaMetaData);
      schemaData.add({
        'schema': schema,
        'schemaMetaData': schemaMetaData,
        'fields': fields,
        'models': models,
      });
    }

    // Write header with complete information
    if (schemaData.isNotEmpty) {
      final firstSchema = schemaData.first;
      _writeFileHeader(buffer, library, buildStep, firstSchema['fields'], firstSchema['models'],
          firstSchema['schemaMetaData']);
    }

    // Second pass: generate all classes
    for (var data in schemaData) {
      _processSchemaData(buffer, data);
    }

    return buffer.toString();
  }

  void _processSchemaData(StringBuffer buffer, Map<String, dynamic> data) {
    final schema = data['schema'] as AnnotatedElement;
    final schemaMetaData = data['schemaMetaData'] as _SchemaMetaData;
    final fields = data['fields'] as List<_FieldDefinition>;
    final models = data['models'] as List<_ModelDefinition>;

    _checkValidSchemaElement(schema);

    // Generate Table class
    buffer.writeln(_generateTableClass(schemaMetaData, fields));

    // Generate Id field
    fields.forEach((field) {
      if (field is _IdField) {
        buffer.writeln(_generateIdClass(field, schemaMetaData));
      }
    });

    buffer.writeln(_generateSchemaBaseClass(schemaMetaData));

    buffer.writeln(_generateModelBaseClass(schemaMetaData, fields));

    // Generate Base Model class
    buffer.writeln(_generateBaseModelClass(schemaMetaData, fields));

    // Generate models
    models.forEach((model) {
      buffer.writeln(_generateModelClass(model, schemaMetaData, fields));
    });
  }

  void _checkValidSchemaElement(AnnotatedElement schema) {
    if (schema.element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Schema annotation can only be applied to classes.',
        element: schema.element,
      );
    }

    final classElement = schema.element as ClassElement;

    if (!classElement.allSupertypes.any((type) => type.element.name == 'KimappSchema')) {
      throw InvalidGenerationSourceError(
        'The class ${classElement.displayName} must extend KimappSchema.',
        element: classElement,
      );
    }
  }

  void _writeFileHeader(
      StringBuffer buffer,
      LibraryReader library,
      BuildStep buildStep,
      List<_FieldDefinition> allFields,
      List<_ModelDefinition> models,
      _SchemaMetaData schemaMetaData) {
    final currentFilePath = buildStep.inputId.path;
    final currentFileName = path.basename(currentFilePath);
    final basename = path.basenameWithoutExtension(currentFilePath);

    buffer.writeln("// Generated from: $currentFileName");
    buffer.writeln("//");
    buffer.writeln("// Generated Classes:");

    // Table class
    final tableFields = allFields.map((f) => f.fieldName).join(', ');
    buffer.writeln(
        "// - ${schemaMetaData.className}Table: Static constants for table/column names - table, $tableFields");

    // ID classes
    for (final field in allFields) {
      if (field is _IdField) {
        final idClassName = field.generateIdClassNameAs ?? '${schemaMetaData.className}Id';
        buffer.writeln(
            "// - $idClassName: Identity<${field.dataType}> wrapper for ${schemaMetaData.className.toLowerCase()} primary key");
      }
    }

    // Base model
    final baseFields = allFields.where((f) => f is! _IgnoreField).map((f) {
      if (f is _IdField) {
        final idType = f.generateIdClassNameAs ?? '${schemaMetaData.className}Id';
        return '${f.fieldName}:$idType';
      }
      return '${f.fieldName}:${f.dataType}';
    }).join(', ');
    buffer.writeln("// - ${schemaMetaData.baseModelName}: $baseFields");

    // Custom models
    for (final model in models) {
      final modelFields = model.fields.map((f) {
        if (f is _IdField) {
          final idType = f.generateIdClassNameAs ?? '${schemaMetaData.className}Id';
          return '${f.fieldName}:$idType';
        }
        return '${f.fieldName}:${f.dataType}';
      }).join(', ');
      buffer.writeln("// - ${model.modelName}: $modelFields");
    }

    buffer.writeln("");
    buffer.writeln(
        "// ignore_for_file: invalid_annotation_target, unused_import, require_trailing_commas");
    buffer.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
    buffer.writeln("import 'package:kimapp/kimapp.dart';");

    final imports = _getSourceFileImports(library);
    for (final import in imports) {
      if (!import.contains(basename)) buffer.writeln(import);
    }

    buffer.writeln("import '$currentFileName';");
    buffer.writeln("part '${basename}.schema.freezed.dart';");
    buffer.writeln("part '${basename}.schema.g.dart';");
  }

  Set<String> _getSourceFileImports(LibraryReader library) {
    final imports = Set<String>();
    for (var import in library.element.importedLibraries) {
      final uri = import.source.uri;
      String importStr = "import '${uri.toString()}';";

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

  Future<LibraryElement> _getLatestLibraryElement(
      BuildStep buildStep, LibraryElement libraryElement) async {
    final resolver = buildStep.resolver;
    return await resolver.libraryFor(await resolver.assetIdForElement(libraryElement));
  }

  String _extractTypeString(TypeArgumentList? typeArguments) {
    if (typeArguments != null && typeArguments.arguments.isNotEmpty) {
      return typeArguments.arguments
          .map((arg) => arg is NamedType ? arg.name2.toString() : 'dynamic')
          .join(', ');
    }
    return 'dynamic';
  }

  Future<List<_ModelDefinition>> _getModels(
    BuildStep buildStep,
    ClassElement element,
    List<_FieldDefinition> baseFields,
    _SchemaMetaData schemaMetaData,
  ) async {
    final models = <_ModelDefinition>[];
    final modelsGetter = element.getGetter('models');
    if (modelsGetter == null) return [];

    // Get the latest library element
    final latestLibraryElement = await _getLatestLibraryElement(buildStep, element.library);

    // Use the latest library element to get the session
    final session = latestLibraryElement.session;
    final result = session.getParsedLibraryByElement(latestLibraryElement);
    if (result is! ParsedLibraryResult) return [];

    final node = result.getElementDeclaration(modelsGetter)?.node;
    if (node is! MethodDeclaration) return [];

    Expression? listExpression;
    if (node.body is ExpressionFunctionBody) {
      listExpression = (node.body as ExpressionFunctionBody).expression;
    } else if (node.body is BlockFunctionBody) {
      final returnStatement = (node.body as BlockFunctionBody)
          .block
          .statements
          .whereType<ReturnStatement>()
          .firstOrNull;
      if (returnStatement != null) {
        listExpression = returnStatement.expression;
      }
    }

    if (listExpression is! ListLiteral) return [];

    for (final element in listExpression.elements) {
      _ModelDefinition? modelDefinition;
      if (element is MethodInvocation) {
        modelDefinition = _parseModelDefinition(element, baseFields, schemaMetaData);
      } else if (element is CascadeExpression) {
        modelDefinition = _parseCascadeModelDefinition(element, baseFields, schemaMetaData);
      }

      if (modelDefinition != null) {
        models.add(modelDefinition);
      }
    }

    return models;
  }

  _ModelDefinition? _parseModelDefinition(
    MethodInvocation invocation,
    List<_FieldDefinition> baseFields,
    _SchemaMetaData schemaMetaData,
  ) {
    String? modelName;
    bool tableEnable = false;
    String? tableName;
    final addedFields = <_FieldDefinition>[];
    bool inheritAllFromBase = false;
    List<String> exceptedFieldNames = [];

    var currentInvocation = invocation;
    while (true) {
      _processInvocation(
        currentInvocation,
        modelName: (name) => modelName = name,
        baseFields: baseFields,
        onTableEnable: (name) {
          tableEnable = true;
          tableName = name;
        },
        onInheritAllFromBase: (excepts) {
          inheritAllFromBase = true;
          exceptedFieldNames = excepts;
        },
        onAddFields: (newFields) => addedFields.addAll(newFields),
        onCopyFields: (copiedFields) => addedFields.addAll(copiedFields),
      );

      if (currentInvocation.target is MethodInvocation) {
        currentInvocation = currentInvocation.target as MethodInvocation;
      } else {
        break;
      }
    }

    return _createModelDefinition(
      modelName: modelName,
      tableEnable: tableEnable,
      tableName: tableName,
      inheritAllFromBase: inheritAllFromBase,
      exceptedFieldNames: exceptedFieldNames,
      addedFields: addedFields,
      baseFields: baseFields,
    );
  }

  _ModelDefinition? _parseCascadeModelDefinition(
    CascadeExpression cascadeExpression,
    List<_FieldDefinition> baseFields,
    _SchemaMetaData schemaMetaData,
  ) {
    String? modelName;
    bool tableEnable = false;
    String? tableName;
    final addedFields = <_FieldDefinition>[];
    bool inheritAllFromBase = false;
    List<String> exceptedFieldNames = [];

    if (cascadeExpression.target is MethodInvocation) {
      final modelInvocation = cascadeExpression.target as MethodInvocation;
      if (modelInvocation.methodName.name == 'Model') {
        modelName = _extractStringArgument(modelInvocation.argumentList);
      }
    }

    for (final section in cascadeExpression.cascadeSections) {
      if (section is MethodInvocation) {
        _processInvocation(
          section,
          modelName: (name) => modelName = name,
          baseFields: baseFields,
          onTableEnable: (name) {
            tableEnable = true;
            tableName = name;
          },
          onInheritAllFromBase: (excepts) {
            inheritAllFromBase = true;
            exceptedFieldNames = excepts;
          },
          onAddFields: (newFields) => addedFields.addAll(newFields),
          onCopyFields: (copiedFields) => addedFields.addAll(copiedFields),
        );
      }
    }

    return _createModelDefinition(
      modelName: modelName,
      tableEnable: tableEnable,
      tableName: tableName,
      inheritAllFromBase: inheritAllFromBase,
      exceptedFieldNames: exceptedFieldNames,
      addedFields: addedFields,
      baseFields: baseFields,
    );
  }

  void _processInvocation(
    MethodInvocation invocation, {
    required void Function(String) modelName,
    required void Function(String?) onTableEnable,
    required void Function(List<String>) onInheritAllFromBase,
    required void Function(List<_FieldDefinition>) onAddFields,
    required void Function(List<_FieldDefinition>) onCopyFields,
    required List<_FieldDefinition> baseFields,
  }) {
    switch (invocation.methodName.name) {
      case 'Model':
        final name = _extractStringArgument(invocation.argumentList);
        if (name != null) modelName(name);
        break;
      case 'table':
        onTableEnable(_extractStringArgument(invocation.argumentList));
        break;
      case 'inheritAllFromBase':
        final excepts = _extractExceptsList(invocation.argumentList);
        onInheritAllFromBase(excepts);
        break;
      case 'addFields':
        final fields = _extractAddedFields(invocation.argumentList, baseFields);
        onAddFields(fields);
        break;
      case 'copyFields':
        final fields = _extractCopyFields(invocation.argumentList, baseFields);
        onCopyFields(fields);
        break;
    }
  }

  _ModelDefinition _createModelDefinition({
    required String? modelName,
    required bool tableEnable,
    required String? tableName,
    required bool inheritAllFromBase,
    required List<String> exceptedFieldNames,
    required List<_FieldDefinition> addedFields,
    required List<_FieldDefinition> baseFields,
  }) {
    final fields = <String, _FieldDefinition>{};

    if (inheritAllFromBase) {
      for (final field in baseFields.where((e) => e is! _IgnoreField)) {
        if (!exceptedFieldNames.contains(field.fieldName)) {
          fields[field.fieldName] = field;
        }
      }
    }

    for (final field in addedFields) {
      fields[field.fieldName] = field;
    }

    return _ModelDefinition(
      modelName: modelName ?? '',
      enableTable: tableEnable,
      tableName: tableName,
      inheritedAllFromBase: inheritAllFromBase,
      exceptedInheritedFieldNames: exceptedFieldNames,
      fields: fields.values.toList(),
    );
  }

  String? _extractStringArgument(ArgumentList argumentList) {
    if (argumentList.arguments.isNotEmpty) {
      final arg = argumentList.arguments.first;
      if (arg is SimpleStringLiteral) {
        return arg.value;
      }
    }
    return null;
  }

  List<String> _extractExceptsList(ArgumentList argumentList) {
    final exceptsList = <String>[];
    if (argumentList.arguments.isNotEmpty) {
      final exceptsArg = argumentList.arguments.first;
      if (exceptsArg is NamedExpression && exceptsArg.name.label.name == 'excepts') {
        final exceptsExpression = exceptsArg.expression;
        if (exceptsExpression is ListLiteral) {
          exceptsList
              .addAll(exceptsExpression.elements.whereType<SimpleIdentifier>().map((e) => e.name));
        }
      }
    }
    return exceptsList;
  }

  List<_FieldDefinition> _extractAddedFields(
      ArgumentList argumentList, List<_FieldDefinition> baseFields) {
    final addedFields = <_FieldDefinition>[];
    if (argumentList.arguments.isNotEmpty) {
      final fieldsArg = argumentList.arguments.first;
      if (fieldsArg is SetOrMapLiteral) {
        for (final entry in fieldsArg.elements) {
          if (entry is MapLiteralEntry) {
            final fieldName = (entry.key as SimpleStringLiteral).value;
            final fieldValue = entry.value;

            if (fieldValue is SimpleIdentifier) {
              final fieldDefinition =
                  baseFields.firstWhereOrNull((e) => e.fieldName == fieldValue.name);
              if (fieldDefinition != null) {
                // Create a new field definition with the map key as the field name
                // but preserve all other properties from the original field
                _FieldDefinition newFieldDefinition;
                if (fieldDefinition is _IdField) {
                  newFieldDefinition = _FieldDefinition.id(
                    fieldName: fieldName,
                    dataType: fieldDefinition.dataType,
                    jsonKey: fieldDefinition.jsonKey,
                    generateIdClassNameAs: fieldDefinition.generateIdClassNameAs,
                  );
                } else if (fieldDefinition is _JoinField) {
                  newFieldDefinition = _FieldDefinition.join(
                    fieldName: fieldName,
                    dataType: fieldDefinition.dataType,
                    jsonKey: fieldDefinition.jsonKey,
                    foreignKey: fieldDefinition.joinFieldForeignKey,
                    candidateKey: fieldDefinition.joinFieldCandidateKey,
                  );
                } else if (fieldDefinition is _IgnoreField) {
                  newFieldDefinition = _FieldDefinition.ignore(
                    fieldName: fieldName,
                    key: fieldDefinition.jsonKey ?? fieldName,
                  );
                } else {
                  newFieldDefinition = _FieldDefinition.normal(
                    fieldName: fieldName,
                    dataType: fieldDefinition.dataType,
                    jsonKey: fieldDefinition.jsonKey,
                  );
                }
                addedFields.add(newFieldDefinition);
                continue;
              } else {
                throw InvalidGenerationSourceError(
                  '${fieldValue.name} of field $fieldName is not defined in the base model.',
                );
              }
            }

            _FieldType? _fieldType;
            String? dataType;

            // Extract field type
            if (fieldValue is MethodInvocation) {
              _fieldType = _FieldType.fromString(fieldValue.methodName.name);
              dataType = _extractTypeString(fieldValue.typeArguments);
            }

            if (dataType == null) {
              throw InvalidGenerationSourceError(
                'Field $fieldName data type is not valid.',
              );
            }

            if (_fieldType == null) {
              throw InvalidGenerationSourceError(
                'Field $fieldName type is not valid.',
              );
            }

            try {
              final fieldDefination = _parseFieldDefinition(fieldName, fieldValue);
              addedFields.add(fieldDefination);
            } catch (e) {
              throw InvalidGenerationSourceError(
                'Error parsing field $fieldName: ${e.toString()}',
              );
            }
          }
        }
      }
    }
    return addedFields;
  }

  List<_FieldDefinition> _extractCopyFields(
      ArgumentList argumentList, List<_FieldDefinition> baseFields) {
    final copiedFields = <_FieldDefinition>[];
    if (argumentList.arguments.isNotEmpty) {
      final fieldsArg = argumentList.arguments.first;
      if (fieldsArg is ListLiteral) {
        for (final element in fieldsArg.elements) {
          if (element is SimpleIdentifier) {
            final fieldDefinition =
                baseFields.firstWhereOrNull((field) => field.fieldName == element.name);
            if (fieldDefinition != null) {
              copiedFields.add(fieldDefinition);
            } else {
              throw InvalidGenerationSourceError(
                'Field ${element.name} is not defined in the base schema.',
              );
            }
          } else {
            throw InvalidGenerationSourceError(
              'copyFields only accepts field identifiers in the array.',
            );
          }
        }
      } else {
        throw InvalidGenerationSourceError(
          'copyFields expects a list of field identifiers.',
        );
      }
    }
    return copiedFields;
  }

  Future<List<_FieldDefinition>> _getFields(BuildStep buildStep, ClassElement element) async {
    final fields = <_FieldDefinition>[];
    final expressions = <String, Expression>{};

    final latestLibraryElement = await _getLatestLibraryElement(buildStep, element.library);

    // Helper function to check if a property is the 'models' property
    bool isModelProperty(String name) => name == 'models';

    // Process getters and fields
    for (var member in [...element.accessors, ...element.fields]) {
      if ((member is PropertyAccessorElement && member.isGetter && !member.isStatic) ||
          (member is FieldElement && !member.isStatic)) {
        if (!isModelProperty(member.name!)) {
          final session = latestLibraryElement.session;
          final result = session.getParsedLibraryByElement(element.library);
          if (result is ParsedLibraryResult) {
            final node = result.getElementDeclaration(member)?.node;
            Expression? expression;
            if (node is MethodDeclaration && node.body is ExpressionFunctionBody) {
              expression = (node.body as ExpressionFunctionBody).expression;
            } else if (node is VariableDeclaration && node.initializer != null) {
              expression = node.initializer!;
            }
            if (expression != null) {
              expressions[member.name!] = expression;
            }
          }
        }
      }
    }

    // Parse the fields
    for (var entry in expressions.entries) {
      if (entry.value.toString().startsWith('Field')) {
        final fieldDefinition = _parseFieldDefinition(entry.key, entry.value);
        // Make sure it has key no matter what
        if (fieldDefinition.jsonKey == null) {
          throw InvalidGenerationSourceError(
            'Cannot generate key for field ${fieldDefinition.fieldName}.',
            node: entry.value,
          );
        }

        if (fieldDefinition.fieldName.isNotEmpty) {
          fields.add(fieldDefinition);
        }
      }
    }

    return fields;
  }

  _FieldDefinition _parseFieldDefinition(String name, Expression expression) {
    _FieldType? fieldType;
    String dataType = 'Invalid';
    String? jsonKey;
    String? generateIdClassNameAs;
    String? joinFieldForeignKey;
    String? joinFieldCandidateKey;

    if (expression is MethodInvocation) {
      final methodChain = _extractMethodChain(expression);
      final baseMethod = methodChain.first;

      fieldType = _FieldType.fromString(baseMethod.methodName.name);

      // Extract type arguments
      if (baseMethod.typeArguments != null) {
        final typeArgs = baseMethod.typeArguments!.arguments.first.toString();
        dataType = typeArgs;
      }

      // Extract key value
      if (baseMethod.argumentList.arguments.isNotEmpty) {
        jsonKey = _extractStringArgument(baseMethod.argumentList);
      }

      // Check for additional method calls
      for (var method in methodChain.skip(1)) {
        switch (method.methodName.name) {
          case 'generateAs':
            generateIdClassNameAs = _extractStringArgument(method.argumentList);
            break;
          case 'withForeignKey':
            joinFieldForeignKey = _extractStringArgument(method.argumentList);
            break;
          case 'withCandidateKey':
            joinFieldCandidateKey = _extractStringArgument(method.argumentList);
            break;
        }
      }
    } else if (expression is InstanceCreationExpression) {
      jsonKey = _extractStringArgument(expression.argumentList);
      fieldType =
          _FieldType.fromString(_extractTypeString(expression.constructorName.type.typeArguments));
    }

    // If it's a join field and no jsonKey was set, use the foreignKey as the jsonKey
    if (fieldType == _FieldType.join && jsonKey == null && joinFieldForeignKey != null) {
      jsonKey = joinFieldForeignKey;
    }

    switch (fieldType) {
      case _FieldType.id:
        return _FieldDefinition.id(
            fieldName: name,
            dataType: dataType,
            jsonKey: jsonKey,
            generateIdClassNameAs: generateIdClassNameAs);
      case _FieldType.join:
        return _FieldDefinition.join(
            fieldName: name,
            dataType: dataType,
            jsonKey: name,
            foreignKey: joinFieldForeignKey,
            candidateKey: joinFieldCandidateKey);
      case _FieldType.ignore:
        return _FieldDefinition.ignore(
          fieldName: name,
          key: jsonKey ?? name,
        );
      default:
        return _FieldDefinition.normal(
          fieldName: name,
          dataType: dataType,
          jsonKey: jsonKey,
        );
    }
  }

  List<MethodInvocation> _extractMethodChain(Expression expression) {
    final methodChain = <MethodInvocation>[];
    var currentExpression = expression;

    while (currentExpression is MethodInvocation) {
      methodChain.insert(0, currentExpression);
      if (currentExpression.target != null) {
        currentExpression = currentExpression.target!;
      } else {
        break;
      }
    }

    return methodChain;
  }
}

class _ModelDefinition {
  const _ModelDefinition({
    required this.modelName,
    required this.enableTable,
    required this.tableName,
    required this.inheritedAllFromBase,
    required this.exceptedInheritedFieldNames,
    required this.fields,
  });

  final bool enableTable;
  final List<_FieldDefinition> fields;
  final bool inheritedAllFromBase;
  final List<String> exceptedInheritedFieldNames;
  final String modelName;
  final String? tableName;

  @override
  String toString() {
    return 'ModelDefinition(modelName: $modelName, enableTable: $enableTable, tableName: $tableName, inheritedAllFromBase: $inheritedAllFromBase, fields: $fields)';
  }
}

class _FieldDefinition {
  _FieldDefinition({
    required this.fieldName,
    required this.dataType,
    required this.fieldType,
    this.jsonKey,
    this.generateIdClassNameAs,
    this.joinFieldForeignKey,
    this.joinFieldCandidateKey,
  });

  factory _FieldDefinition.id({
    required String fieldName,
    required String dataType,
    String? jsonKey,
    String? generateIdClassNameAs,
  }) =>
      _IdField(
        fieldName: fieldName,
        dataType: dataType,
        jsonKey: jsonKey,
        generateIdClassNameAs: generateIdClassNameAs,
      );

  factory _FieldDefinition.ignore({
    required String fieldName,
    required String key,
  }) =>
      _IgnoreField(
        fieldName: fieldName,
        key: key,
      );

  factory _FieldDefinition.join({
    required String fieldName,
    required String dataType,
    String? jsonKey,
    String? foreignKey,
    String? candidateKey,
  }) =>
      _JoinField(
        fieldName: fieldName,
        dataType: dataType,
        jsonKey: jsonKey,
        foreignKey: foreignKey,
        candidateKey: candidateKey,
      );

  factory _FieldDefinition.normal({
    required String fieldName,
    required String dataType,
    String? jsonKey,
  }) =>
      _NormalField(
        fieldName: fieldName,
        dataType: dataType,
        jsonKey: jsonKey,
      );

  final String dataType;
  final String fieldName;
  final _FieldType fieldType;
  final String? generateIdClassNameAs;
  final String? joinFieldCandidateKey;
  final String? joinFieldForeignKey;
  final String? jsonKey;

  bool get isNumber =>
      dataType.contains('int') || dataType.contains('double') || dataType.contains('num');
  bool get isString => dataType.contains('String');

  @override
  String toString() {
    return '_FieldDefinition(fieldType: $fieldType, fieldName: $fieldName, jsonKey: $jsonKey, dataType: $dataType, generateIdClassNameAs: $generateIdClassNameAs, joinFieldForeignKey: $joinFieldForeignKey, joinFieldCandidateKey: $joinFieldCandidateKey)';
  }
}

class _IdField extends _FieldDefinition {
  _IdField({
    required String fieldName,
    required String dataType,
    String? jsonKey,
    String? generateIdClassNameAs,
  }) : super(
          fieldName: fieldName,
          dataType: dataType,
          fieldType: _FieldType.id,
          jsonKey: jsonKey,
          generateIdClassNameAs: generateIdClassNameAs,
        );
}

class _JoinField extends _FieldDefinition {
  _JoinField({
    required String fieldName,
    required String dataType,
    String? jsonKey,
    String? foreignKey,
    String? candidateKey,
  }) : super(
          fieldName: fieldName,
          dataType: dataType,
          fieldType: _FieldType.join,
          jsonKey: jsonKey,
          joinFieldForeignKey: foreignKey,
          joinFieldCandidateKey: candidateKey,
        );
}

class _IgnoreField extends _FieldDefinition {
  _IgnoreField({
    required String fieldName,
    required String key,
  }) : super(
          fieldName: fieldName,
          dataType: key,
          fieldType: _FieldType.ignore,
        );
}

class _NormalField extends _FieldDefinition {
  _NormalField({
    required String fieldName,
    required String dataType,
    String? jsonKey,
  }) : super(
          fieldName: fieldName,
          dataType: dataType,
          fieldType: _FieldType.normal,
          jsonKey: jsonKey,
        );
}

enum _FieldType {
  id,
  normal,
  ignore,
  join;

  static _FieldType fromString(String methodName) {
    switch (methodName) {
      case 'id':
        return _FieldType.id;
      case 'join':
        return _FieldType.join;
      case 'ignore':
        return _FieldType.ignore;
      default:
        return _FieldType.normal;
    }
  }

  String typeString([String? type]) {
    String base;

    switch (this) {
      case _FieldType.id:
        base = 'Field.id';
      case _FieldType.join:
        base = 'Field.join';
      default:
        base = 'Field';
    }

    if (type == null || type.isEmpty) {
      return base;
    }

    return '$base<$type>';
  }
}

class _SchemaMetaData {
  _SchemaMetaData({required this.tableName, required this.className, required this.baseModelName});

  factory _SchemaMetaData.fromAnnotation(ConstantReader annotation) {
    final tableName = annotation.read('tableName').stringValue;
    final className = annotation.peek('className')?.stringValue ?? tableName.pascalCase;
    final baseModelName = annotation.peek('baseModelName')?.stringValue ?? '${className}BaseModel';

    return _SchemaMetaData(
      tableName: tableName,
      className: className,
      baseModelName: baseModelName,
    );
  }

  final String baseModelName;
  final String className;
  final String tableName;
}

String _generateTableClass(_SchemaMetaData schema, List<_FieldDefinition> fields) {
  final buffer = StringBuffer();
  final className = schema.className;
  final tableName = schema.tableName;
  buffer.writeln("class ${className}Table {");
  buffer.writeln("  const ${className}Table._();");
  buffer.writeln('  static const String table = "${tableName.toLowerCase()}";');
  for (final field in fields) {
    String keyValue;
    if (field is _JoinField) {
      keyValue = field.fieldName;
    } else {
      keyValue = field.jsonKey ?? field.fieldName;
    }
    buffer.writeln('  static const String ${field.fieldName} = "$keyValue";');
  }
  buffer.writeln("}");
  return buffer.toString();
}

String _generateIdClass(_IdField idField, _SchemaMetaData schema) {
  final idClassName = idField.generateIdClassNameAs ?? '${schema.className}Id';
  final buffer = StringBuffer();
  buffer.writeln('class $idClassName extends Identity<${idField.dataType}> {');
  buffer.writeln('  const $idClassName._(this.value);');
  buffer.writeln('  @override');
  buffer.writeln('  final ${idField.dataType} value;');
  buffer.writeln('  factory $idClassName.fromJson(dynamic value) {');
  buffer.writeln('    if (value is ${idField.dataType}) {');
  buffer.writeln('      return $idClassName._(value);');
  buffer.writeln('    } else if (value == null) {');
  buffer.writeln('      throw ArgumentError.notNull(\'value\');');
  buffer.writeln('    } else {');
  buffer.writeln(
      '      throw ArgumentError(\'Value of $idClassName must be of type ${idField.dataType}, but was \${value.runtimeType}. Please provide the correct type.\');');
  buffer.writeln('    }');
  buffer.writeln('  }');
  buffer.writeln('  factory $idClassName.fromValue(${idField.dataType} value) {');
  buffer.writeln('    return $idClassName._(value);');
  buffer.writeln('  }');
  if (idField.isNumber || idField.isString) {
    final emptyValue = idField.isNumber ? -1 : '""';
    buffer.writeln('  /// Creates an instance of $idClassName with a value of $emptyValue.');
    buffer.writeln(
        '  /// This is used to represent an empty or invalid $idClassName for placeholder or default values of form fields.');
    buffer.writeln(
        '  /// WARNING: This is not a valid $idClassName access it value through [value] or [call] will throw an error.');
    buffer.writeln('  factory $idClassName.empty() => $idClassName._($emptyValue);');
  }
  buffer.writeln('}');
  return buffer.toString();
}

String _baseSchemaBaseClassName(_SchemaMetaData schemaMetaData) {
  return 'Base${schemaMetaData.className}Schema';
}

String _generateSchemaBaseClass(_SchemaMetaData schemaMetaData) {
  return '''
    abstract class ${_baseSchemaBaseClassName(schemaMetaData)} {}
''';
}

String _baseModelBaseClassName(_SchemaMetaData schemaMetaData) {
  return 'I${schemaMetaData.className}Model';
}

String _generateModelBaseClass(_SchemaMetaData schemaMetaData, List<_FieldDefinition> allFields) {
  final buffer = StringBuffer();

  buffer.writeln('abstract class ${_baseModelBaseClassName(schemaMetaData)} {');
  for (final field in allFields) {
    final dataType = field is _IdField
        ? (field.generateIdClassNameAs ?? '${schemaMetaData.className}Id')
        : field.dataType;
    buffer.writeln('  $dataType get ${field.fieldName};');
  }
  buffer.writeln('}');

  return buffer.toString();
}

String _generateBaseModelClass(_SchemaMetaData schema, List<_FieldDefinition> allFields) {
  final buffer = StringBuffer();
  final baseModelName = schema.baseModelName;
  final tableName = schema.tableName;

  final fields = allFields.where((field) => field is! _IgnoreField).toList();
  final idField = fields.firstWhereOrNull((field) => field is _IdField) as _IdField?;

  final baseClass = _baseSchemaBaseClassName(schema);

  buffer.writeln('@freezed');
  buffer.writeln(
      'sealed class $baseModelName with _\$$baseModelName implements $baseClass, ${_baseModelBaseClassName(schema)} {');
  buffer.writeln('  const $baseModelName._();');

  buffer.writeln('  @TableModel(${baseModelName}.tableName)');
  buffer.writeln('  @JsonSerializable(explicitToJson: true)');
  buffer.write('  const factory $baseModelName(');

  if (fields.isNotEmpty) {
    buffer.writeln('{');

    // Handle ID field first
    if (idField != null) {
      final idType = idField.generateIdClassNameAs ?? '${schema.className}Id';
      final keyValue = idField.jsonKey ?? idField.fieldName;
      buffer.writeln(
          '    @JsonKey(name: "$keyValue") required $idType ${idField.fieldName.camelCase},');
    }

    // Handle other fields
    for (final field in fields) {
      if (field is! _IdField) {
        final keyValue = field.jsonKey ?? field.fieldName;
        if (field is _JoinField) {
          buffer.writeln(
              '    @JoinedColumn(foreignKey: ${field.joinFieldForeignKey == null ? null : '"${field.joinFieldForeignKey}"'}, candidateKey: ${field.joinFieldCandidateKey == null ? null : '"${field.joinFieldCandidateKey}"'})');
          buffer.writeln(
              '    @JsonKey(name: "$keyValue") required ${field.dataType} ${field.fieldName.camelCase},');
        } else {
          buffer.writeln(
              '    @JsonKey(name: "$keyValue") required ${field.dataType} ${field.fieldName.camelCase},');
        }
      }
    }

    buffer.writeln('  }');
  }

  buffer.writeln(') = _$baseModelName;');
  buffer.writeln(
      '  factory $baseModelName.fromJson(Map<String, dynamic> json) => _\$${baseModelName}FromJson(json);');
  buffer.writeln('  static const TableBuilder table = _table$baseModelName;');
  buffer.writeln('  static const String tableName = "$tableName";');
  buffer.writeln('}');

  return buffer.toString();
}

String _generateModelClass(
    _ModelDefinition model, _SchemaMetaData schema, List<_FieldDefinition> baseFields) {
  final buffer = StringBuffer();

  final baseClass = _baseSchemaBaseClassName(schema);

  final additionalImplements =
      model.inheritedAllFromBase && model.exceptedInheritedFieldNames.isEmpty
          ? "," + _baseModelBaseClassName(schema)
          : '';
  buffer.writeln('@freezed');
  buffer.writeln(
    'sealed class ${model.modelName} with _\$${model.modelName} implements $baseClass $additionalImplements {',
  );
  buffer.writeln('  const ${model.modelName}._();');

  if (model.enableTable) {
    buffer.writeln('  @TableModel(${model.modelName}.tableName)');
  }

  buffer.writeln('  @JsonSerializable(explicitToJson: true)');
  buffer.write('  const factory ${model.modelName}(');

  final fields = <String>[];

  // Generate fields
  for (final field in model.fields) {
    final keyValue = field.jsonKey ?? field.fieldName;
    if (field is _IdField) {
      final idType = field.generateIdClassNameAs ?? '${schema.className}Id';
      fields.add('    @JsonKey(name: "$keyValue") required $idType ${field.fieldName.camelCase},');
    } else if (field is _JoinField) {
      fields.add(
          '    @JoinedColumn(foreignKey: ${field.joinFieldForeignKey == null ? null : '"${field.joinFieldForeignKey}"'}, candidateKey: ${field.joinFieldCandidateKey == null ? null : '"${field.joinFieldCandidateKey}"'})');
      fields.add(
          '    @JsonKey(name: "$keyValue") required ${field.dataType} ${field.fieldName.camelCase},');
    } else {
      fields.add(
          '    @JsonKey(name: "$keyValue") required ${field.dataType} ${field.fieldName.camelCase},');
    }
  }

  if (fields.isNotEmpty) {
    buffer.writeln('{');
    buffer.writeln(fields.join('\n'));
    buffer.writeln('  })');
  } else {
    buffer.writeln(')');
  }

  buffer.writeln(' = _${model.modelName};');
  buffer.writeln(
      '  factory ${model.modelName}.fromJson(Map<String, dynamic> json) => _\$${model.modelName}FromJson(json);');

  if (model.enableTable) {
    buffer.writeln('  static const TableBuilder table = _table${model.modelName};');
    buffer.writeln('  static const String tableName = "${model.tableName ?? schema.tableName}";');
  }

  if (model.inheritedAllFromBase && model.exceptedInheritedFieldNames.isEmpty) {
    buffer.writeln('  ${schema.baseModelName} to${schema.baseModelName}() {');
    buffer.writeln('    return ${schema.baseModelName}(');
    for (final field in baseFields) {
      if (field is _IdField) {
        buffer.writeln('      ${field.fieldName}: ${field.fieldName},');
      } else {
        buffer.writeln('      ${field.fieldName}: ${field.fieldName},');
      }
    }
    buffer.writeln('    );');
    buffer.writeln('  }');
  }

  buffer.writeln('}');

  return buffer.toString();
}
