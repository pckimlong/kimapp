const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../../utils/helpers');

/**
 * Generate an update provider file for a feature
 * @param {string} providersPath - The path to the providers directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateUpdateProviderFile(providersPath, name) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  const content = `import 'package:autoverpod/autoverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../${snakeCaseName}_schema.schema.dart';
import '${snakeCaseName}_detail_provider.dart';
import '${snakeCaseName}_list_pagination_provider.dart';
import '${snakeCaseName}_list_provider.dart';

part '${snakeCaseName}_update_provider.g.dart';

@formWidget
@riverpod
class ${pascalCaseName}Update extends AsyncNotifier<${pascalCaseName}UpdateParam> {
  @override
  Future<${pascalCaseName}UpdateParam> build(${pascalCaseName}Id ${camelCaseName}Id) async {
    final result = await ref.read(${camelCaseName}RepoProvider).findOne(${camelCaseName}Id).getOrThrow();
    throw UnimplementedError();
  }

  @override
  Future<${pascalCaseName}Model> submit(${pascalCaseName}UpdateParam state) async {
    return await ref.read(${camelCaseName}RepoProvider).update(${camelCaseName}Id, data: state).getOrThrow();
  }

  @override
  void onSuccess(${pascalCaseName}Model result) {
    ref.read(${camelCaseName}ListProvider.notifier).updateItem(result);
    ref.read(${camelCaseName}DetailProvider(${camelCaseName}Id).notifier).updateState((_) => result);

    //! Use with caution
    /// this update might lead to data inconsistency, for example, if we have update the item to not meet the param filter
    /// in this case, the item should be removed from the paginated list, but using this method will just update the item
    /// other case is if we update sort order, the item might need to change position
    ${pascalCaseName}PaginationTracker.instance.updatePaginatedItem(ref, result);
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_update_provider.dart`), content);
}

module.exports = {
  generateUpdateProviderFile,
}; 