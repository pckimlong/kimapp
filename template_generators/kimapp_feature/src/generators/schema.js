const fs = require('fs-extra');
const path = require('path');
const { toPascalCase } = require('../utils/helpers');

/**
 * Generate a schema file for a feature
 * @param {string} featurePath - The path to the feature directory
 * @param {string} name - The feature name in snake_case
 * @param {string} idDataType - The data type of the ID field
 * @returns {Promise<void>}
 */
async function generateSchemaFile(featurePath, name, idDataType) {
  const pascalCaseName = toPascalCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:kimapp/kimapp.dart';

@Schema(
  tableName: '${snakeCaseName}s',
  className: '${pascalCaseName}',
  baseModelName: '${pascalCaseName}Model',
)
class ${pascalCaseName}Schema extends KimappSchema {
  final id = Field.id<${idDataType}>('id').generateAs('${pascalCaseName}Id');
  final name = Field<String>('name');

  @override
  List<Model> get models {
    return [
      Model('${pascalCaseName}LiteModel')
        ..table()
        ..addFields({'id': id, 'name': name}),
      Model('${pascalCaseName}DetailModel')
        ..table()
        ..inheritAllFromBase()
        ..addFields({
          'createdAt': Field<DateTime>('created_at'),
        }),

      // Params
      Model('${pascalCaseName}CreateParam')..addFields({}),
      Model('${pascalCaseName}UpdateParam')..addFields({}),
    ];
  }
}
`;

  await fs.writeFile(path.join(featurePath, `${snakeCaseName}_schema.dart`), content);
}

module.exports = {
  generateSchemaFile,
}; 