import 'package:riverpod_widget/src/generators/form_widget/form_widget_names.dart';
import 'package:riverpod_widget/src/models/provider_definition.dart';
import 'package:riverpod_widget/src/templates/inherited_widget.dart';
import 'package:riverpod_widget/src/templates/utils.dart';

String generateParamInheritedWidget(ProviderDefinition provider) {
  if (!provider.hasFamily) return '';
  return generateInheritedWidget(
    name: provider.formInheritedWidgetName,
    fields: [
      ClassField(name: 'formKey', type: 'GlobalKey<FormState>', isRequired: true),
      ClassField(name: 'params', type: provider.familyAsRecordType, isRequired: true),
    ],
  );
}
