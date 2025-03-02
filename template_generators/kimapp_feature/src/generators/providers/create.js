const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../../utils/helpers');

/**
 * Generate a create provider file for a feature
 * @param {string} providersPath - The path to the providers directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateCreateProviderFile(providersPath, name) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:autoverpod/autoverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../${snakeCaseName}_schema.schema.dart';
import '${snakeCaseName}_list_provider.dart';
import '${snakeCaseName}_list_pagination_provider.dart';

part '${snakeCaseName}_create_provider.g.dart';

@formWidget
@riverpod
class ${pascalCaseName}Create extends _$${pascalCaseName}CreateWidget {
  @override
  ${pascalCaseName}CreateParam build() => const ${pascalCaseName}CreateParam();

  @override
  Future<${pascalCaseName}Model> submit(${pascalCaseName}CreateParam state) async {
    return await ref.read(${camelCaseName}RepoProvider).create(state).getOrThrow();
  }

  @override
  void onSuccess(${pascalCaseName}Model result) {
    ref.read(${camelCaseName}ListProvider.notifier).insertItem(result);
    ref.invalidate(${camelCaseName}ListPaginationProvider);
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_create_provider.dart`), content);
}

module.exports = {
  generateCreateProviderFile,
}; 