import 'package:recase/recase.dart';
import 'package:autoverpod_generator/src/models/provider_definition.dart';

import '../../models/field_definition.dart';

extension FormWidgetNames on ProviderDefinition {
  String get formWidgetName => '${baseName}FormScope';
  String get formBaseProxyWidgetName => '_${baseName}ProxyWidgetRef';
  String get formInheritedWidgetName => '_${baseName}FormInheritedWidget';
  String get formParamWidgetName => '${baseName}FormParams';
  String get formStateWidgetName => '${baseName}FormState';
  String get formSelectWidgetName => '${baseName}FormSelect';
  String get formStatusWidgetName => '${baseName}FormStatus';

  String fieldWidgetName(FieldDefinition field) => '$baseName${field.name.pascalCase}Field';

  String get callStatusProviderName => '${baseName.camelCase}CallStatusProvider';

  String get callFunctionReturnType {
    return 'Future<AsyncValue<${getSubmitMethodInfo().rawResultType}>>';
  }

  String callStatusProviderNameWithFamily({String prefix = ''}) {
    if (!hasFamily) return callStatusProviderName;
    return '$callStatusProviderName(${familyAsRecordBindString(prefix: prefix)})';
  }

  String get paramsDeclaration {
    if (!hasFamily) return '';
    return 'final params = $formInheritedWidgetName.of(context).params;';
  }
}
