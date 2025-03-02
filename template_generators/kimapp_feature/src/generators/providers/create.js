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
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_utils/kimapp_utils.dart';

import '../i_${snakeCaseName}_repo.dart';
import '../${snakeCaseName}_schema.schema.dart';

part '${snakeCaseName}_create_provider.g.dart';

@stateWidget
@riverpod
class ${pascalCaseName}Create extends _$${pascalCaseName}Create {
  @override
  FutureOr<void> build() {}

  Future<${pascalCaseName}Model> create(${pascalCaseName}CreateParam param) async {
    state = const AsyncLoading();
    
    final result = await ref.read(${camelCaseName}RepoProvider).create(param);
    
    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        throw failure;
      },
      (data) {
        state = const AsyncData(null);
        return data;
      },
    );
  }
}`;

  await fs.writeFile(path.join(providersPath, `${snakeCaseName}_create_provider.dart`), content);
}

module.exports = {
  generateCreateProviderFile,
}; 