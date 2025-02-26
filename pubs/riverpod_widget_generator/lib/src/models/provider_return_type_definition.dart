// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unintended_html_in_doc_comment

import 'package:analyzer/dart/element/type.dart';
import 'package:riverpod_widget_generator/src/models/class_definition.dart';

class ProviderReturnTypeDefinition {
  final String rawType;

  /// Base provider return type, eg Future<int> -> int,
  final String baseType;

  /// Outer type, eg Future<int> -> Future, Stream<int> -> Stream
  final String? wrapperType;

  /// Class info, depends on the base type, if it is raw type, then this is null, if it is a class type, then this is the class info
  final ClassDefinition? classInfo;

  ProviderReturnTypeDefinition({
    required this.rawType,
    required this.baseType,
    required this.wrapperType,
    required this.classInfo,
  });

  factory ProviderReturnTypeDefinition.parse(DartType type, {bool parseClassInfo = false}) {
    final isGeneric = type is ParameterizedType && type.typeArguments.isNotEmpty;
    String baseType = type.toString();
    if (isGeneric) {
      baseType = type.typeArguments.map((t) => t.toString()).join(', ');
    }

    return ProviderReturnTypeDefinition(
      rawType: type.getDisplayString(),
      baseType: baseType,
      wrapperType: type is InterfaceType ? type.element.name : null,
      classInfo:
          isGeneric && parseClassInfo ? ClassDefinition.parse(type.typeArguments.first) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rawType': rawType,
      'baseType': baseType,
      'wrapperType': wrapperType,
      'classInfo': classInfo?.toMap(),
    };
  }
}
