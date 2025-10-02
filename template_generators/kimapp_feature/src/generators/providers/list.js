const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../../utils/helpers');

/**
 * Generate a list provider file for a feature
 * @param {string} providersPath - The path to the providers directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateListProviderFile(providersPath, name) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:autoverpod/autoverpod.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../${snakeCaseName}_schema.schema.dart';
import '../params/${snakeCaseName}_list_param.dart';

part '${snakeCaseName}_list_provider.g.dart';

@stateWidget
@riverpod
class ${pascalCaseName}List extends AsyncNotifier<IList<${pascalCaseName}Model>> with IListAsyncNotifier<${pascalCaseName}Model> {
  @override
  bool comparer(${pascalCaseName}Model a, ${pascalCaseName}Model b) => a.id == b.id;

  @override
  FutureOr<IList<${pascalCaseName}Model>> build() {
    return ref.watch(${camelCaseName}RepoProvider).findAll(${pascalCaseName}ListParam()).getOrThrow();
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_list_provider.dart`), content);
}

module.exports = {
  generateListProviderFile,
}; 