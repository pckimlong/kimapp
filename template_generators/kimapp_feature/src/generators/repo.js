const fs = require('fs-extra');
const path = require('path');
const { toPascalCase, toCamelCase } = require('../utils/helpers');

/**
 * Generate a repository file for a feature
 * @param {string} featurePath - The path to the feature directory
 * @param {string} name - The feature name in snake_case
 * @param {string} idDataType - The data type of the ID field
 * @returns {Promise<void>}
 */
async function generateRepoFile(featurePath, name, idDataType) {
  const pascalCaseName = toPascalCase(name);
  const camelCaseName = toCamelCase(name);
  const snakeCaseName = name; // Already in snake case
  
  const content = `import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';

import 'params/${snakeCaseName}_list_param.dart';
import '${snakeCaseName}_schema.schema.dart';

part 'i_${snakeCaseName}_repo.g.dart';


@Riverpod(keepAlive: true)
I${pascalCaseName}Repo ${camelCaseName}Repo(Ref ref) => _Impl(ref);


abstract class I${pascalCaseName}Repo {
  Future<Either<Failure, IList<${pascalCaseName}Model>>> findAll();

  Future<Either<Failure, ${pascalCaseName}Model>> findOne(${pascalCaseName}Id id);

  Future<Either<Failure, ${pascalCaseName}Model>> create(${pascalCaseName}CreateParam data);

  Future<Either<Failure, ${pascalCaseName}Model>> update(${pascalCaseName}Id ${camelCaseName}Id ,{required ${pascalCaseName}UpdateParam data});

  Future<Either<Failure, Unit>> delete(${pascalCaseName}Id id);

  Future<Either<Failure, IList<${pascalCaseName}Model>>> findPagination({
    required int limit,
    required int offset,
    required ${pascalCaseName}ListParam param,
  });
}



class _Impl implements I${pascalCaseName}Repo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure,  ${pascalCaseName}Model>> create(${pascalCaseName}CreateParam data) async{
   return await errorHandler(() async {
   return await _ref.supabaseClient
    .from(${pascalCaseName}Model.table.tableName)
    .insert(data.toJson())
    .select(${pascalCaseName}Model.table.selectStatement)
    .single()
    .withConverter((data) => right(${pascalCaseName}Model.fromJson(data)));
   });
  }

  @override
  Future<Either<Failure, Unit>> delete(${pascalCaseName}Id id) async{
    return await errorHandler(() async {
    await _ref.supabaseClient
    .from(${pascalCaseName}Table.table)
    .delete()
    .eq(${pascalCaseName}Table.id, id.value);
    
    return right(unit);
    });
  }

  @override
  Future<Either<Failure, IList<${pascalCaseName}Model>>> findAll() async{
    return await errorHandler(() async {
    var query = _ref.supabaseClient.from(${pascalCaseName}Model.table.tableName).select(${pascalCaseName}Model.table.selectStatement);
    
    if (true) {}
    
    return await query.withConverter((data) {
      final items = IList.fromJson(
        data,
        (json) => ${pascalCaseName}Model.fromJson(json as Map<String, dynamic>),
      );
      return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  ${pascalCaseName}Model>> findOne(${pascalCaseName}Id id) async{
   return await errorHandler(() async {
   final query = _ref.supabaseClient
   .from(${pascalCaseName}Model.table.tableName)
   .select(${pascalCaseName}Model.table.selectStatement)
   .eq(${pascalCaseName}Table.id, id.value);
   
   final result = await query.single();
   return right(${pascalCaseName}Model.fromJson(result));
   });
  }

  @override
  Future<Either<Failure, IList<${pascalCaseName}Model>>> findPagination({
    required int limit,
    required int offset,
    required ${pascalCaseName}ListParam param,
  }) async{
    return await errorHandler(() async {
      var query = _ref.supabaseClient.from(${pascalCaseName}Model.table.tableName).select(${pascalCaseName}Model.table.selectStatement);
    
    if (true) {}
    
    return await query
    .limit(limit)
    .range(offset, offset + limit)
    .withConverter((data) {
      final items = IList.fromJson(
        data,
        (json) => ${pascalCaseName}Model.fromJson(json as Map<String, dynamic>),
      );
      return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  ${pascalCaseName}Model>> update(${pascalCaseName}Id ${camelCaseName}Id ,{required ${pascalCaseName}UpdateParam data}) async{
    return await errorHandler(() async {
    return await _ref.supabaseClient
    .from(${pascalCaseName}Model.table.tableName)
    .update(data.toJson())
    .eq(${pascalCaseName}Table.id, ${camelCaseName}Id.value)
    .select(${pascalCaseName}Model.table.selectStatement)
    .single()
    .withConverter((data) => right(${pascalCaseName}Model.fromJson(data)));
    });
  }
}
`;

  await fs.writeFile(path.join(featurePath, `i_${snakeCaseName}_repo.dart`), content);
}

module.exports = {
  generateRepoFile,
}; 