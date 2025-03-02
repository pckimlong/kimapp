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
  
  const content = `import 'package:autoverpod/autoverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../${snakeCaseName}_schema.schema.dart';
import '${snakeCaseName}_list_provider.dart';

part '${snakeCaseName}_delete_provider.g.dart';

@stateWidget
@riverpod
class ${pascalCaseName}Delete extends _$${pascalCaseName}Delete {
  @override
  FutureOr<void> build() {}

  Future<void> delete(${pascalCaseName}Id id) async {
    state = const AsyncLoading();
    
    final result = await ref.read(${camelCaseName}RepoProvider).delete(id);
    
    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        throw failure;
      },
      (_) {
        state = const AsyncData(null);
        
        // Refresh list
        ref.invalidate(${pascalCaseName}ListProvider);
      },
    );
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_delete_provider.dart`), content);
}

module.exports = {
  generateDeleteProviderFile,
}; 