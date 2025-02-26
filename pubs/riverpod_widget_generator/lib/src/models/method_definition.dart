import 'package:analyzer/dart/element/element.dart';

import 'param_definition.dart';

class MethodDefinition {
  final String name;
  final String returnType;
  final List<ParamDefinition> parameters;

  final bool isStatic;
  final List<String> annotations;
  final String? documentation;

  MethodDefinition({
    required this.name,
    required this.returnType,
    this.parameters = const [],
    this.isStatic = false,
    this.annotations = const [],
    this.documentation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'returnType': returnType.replaceFirst(r'$', 'dollar_sign_'),
      'parameters': parameters.map((x) => x.toMap()).toList(),
      'isStatic': isStatic,
      'annotations': annotations,
      'documentation': documentation,
    };
  }

  factory MethodDefinition.parseMethod(MethodElement method) {
    return MethodDefinition(
      name: method.name,
      returnType: method.returnType.getDisplayString(),
      parameters: method.parameters.map((p) => ParamDefinition.parse(p)).toList(),
      isStatic: method.isStatic,
      annotations: method.metadata.map((m) => m.toSource()).toList(),
      documentation: method.documentationComment,
    );
  }

  factory MethodDefinition.parseGetter(PropertyAccessorElement getter) {
    return MethodDefinition(
      name: getter.name,
      returnType: getter.returnType.getDisplayString(),
      parameters: getter.parameters.map((p) => ParamDefinition.parse(p)).toList(),
      isStatic: getter.isStatic,
      annotations: getter.metadata.map((m) => m.toSource()).toList(),
      documentation: getter.documentationComment,
      // body: getter.source.contents.data,
    );
  }
}
