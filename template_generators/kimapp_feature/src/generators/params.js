const fs = require('fs-extra');
const path = require('path');
const { toPascalCase } = require('../utils/helpers');

/**
 * Generate a list parameter file for a feature
 * @param {string} paramsPath - The path to the params directory
 * @param {string} name - The feature name in snake_case
 * @returns {Promise<void>}
 */
async function generateListParamFile(paramsPath, name) {
  const pascalCaseName = toPascalCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:freezed_annotation/freezed_annotation.dart';

part '${snakeCaseName}_list_param.freezed.dart';

@freezed
class ${pascalCaseName}ListParam with _$${pascalCaseName}ListParam {
  const ${pascalCaseName}ListParam._();

  @JsonSerializable(explicitToJson: true)
  const factory ${pascalCaseName}ListParam({
    String? search,
  }) = _${pascalCaseName}ListParam;
}`;

  await fs.writeFile(path.join(paramsPath, `${snakeCaseName}_list_param.dart`), content);
}

module.exports = {
  generateListParamFile,
}; 