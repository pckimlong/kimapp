const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../../utils/helpers');

/**
 * Generate a detail provider file for a feature
 * @param {string} providersPath - The path to the providers directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateDetailProviderFile(providersPath, name) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:autoverpod/autoverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../${snakeCaseName}_schema.schema.dart';

part '${snakeCaseName}_detail_provider.g.dart';

@stateWidget
@riverpod
class ${pascalCaseName}Detail extends _$${pascalCaseName}Detail {
  @override
  FutureOr<${pascalCaseName}Model> build(${pascalCaseName}Id id) {
    return ref.watch(${camelCaseName}RepoProvider).findOne(id).getOrThrow();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_detail_provider.dart`), content);
}

module.exports = {
  generateDetailProviderFile,
}; 