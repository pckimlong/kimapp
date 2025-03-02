const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../../utils/helpers');

/**
 * Generate a delete provider file for a feature
 * @param {string} providersPath - The path to the providers directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateDeleteProviderFile(providersPath, name) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:fpdart/fpdart.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../${snakeCaseName}_schema.schema.dart';
import '../i_${snakeCaseName}_repo.dart';
import '${snakeCaseName}_detail_provider.dart';
import '${snakeCaseName}_list_pagination_provider.dart';
import '${snakeCaseName}_list_provider.dart';

part '${snakeCaseName}_delete_provider.g.dart';

@riverpod
class ${pascalCaseName}Delete extends _$${pascalCaseName}Delete {
  @override
  ProviderStatus<Unit> build(${pascalCaseName}Id id) => const ProviderStatus.initial();

  Future<ProviderStatus<Unit>> call() async {
    return await perform((state) async {
     final result = await ref.read(${camelCaseName}RepoProvider).delete(id);
     return result.getOrThrow();
    }, onSuccess: (success) {
      ref.read(${camelCaseName}ListProvider.notifier).removeWhere((e) => e.id == id);
      ref.invalidate(${camelCaseName}DetailProvider(id));

      /// Can set the invalidateOnLength to 0, but if it just 1, the invalidate is not expensive, it deserve to be used
      /// since it will help accurate the data consistency
      ${pascalCaseName}PaginationTracker.instance.deletePaginatedItem(ref, id, invalidateOnLength: 1);
    },);
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_delete_provider.dart`), content);
}

module.exports = {
  generateDeleteProviderFile,
}; 