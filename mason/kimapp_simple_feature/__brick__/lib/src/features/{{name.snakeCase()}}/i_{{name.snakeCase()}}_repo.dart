import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';

import 'params/{{name.snakeCase()}}_list_param.dart';
import '{{name.snakeCase()}}_schema.schema.dart';

part 'i_{{name.snakeCase()}}_repo.g.dart';


@Riverpod(keepAlive: true)
I{{name.pascalCase()}}Repo {{name.camelCase()}}Repo(Ref ref) => _Impl(ref);


abstract class I{{name.pascalCase()}}Repo {
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll();

  Future<Either<Failure, {{name.pascalCase()}}Model>> findOne({{name.pascalCase()}}Id id);

  Future<Either<Failure, {{name.pascalCase()}}Model>> create({{name.pascalCase()}}CreateParam data);

  Future<Either<Failure, {{name.pascalCase()}}Model>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required {{name.pascalCase()}}UpdateParam data});

  Future<Either<Failure, Unit>> delete({{name.pascalCase()}}Id id);

  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findPagination({
    required int limit,
    required int offset,
    required {{name.pascalCase()}}ListParam param,
  });
}



class _Impl implements I{{name.pascalCase()}}Repo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure,  {{name.pascalCase()}}Model>> create({{name.pascalCase()}}CreateParam data) async{
   return await errorHandler(() async {
   return await _ref.supabaseClient
    .from({{name.pascalCase()}}Model.table.tableName)
    .insert(data.toJson())
    .select({{name.pascalCase()}}Model.table.selectStatement)
    .single()
    .withConverter((data) => right({{name.pascalCase()}}Model.fromJson(data)));
   });
  }

  @override
  Future<Either<Failure, Unit>> delete({{name.pascalCase()}}Id id) async{
    return await errorHandler(() async {
    await _ref.supabaseClient
    .from({{name.pascalCase()}}Table.table)
    .delete()
    .eq({{name.pascalCase()}}Table.id, id.value);
    
    return right(unit);
    });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll() async{
    return await errorHandler(() async {
    var query = _ref.supabaseClient.from({{name.pascalCase()}}Model.table.tableName).select({{name.pascalCase()}}Model.table.selectStatement);
    
    if (true) {}
    
    return await query.withConverter((data) {
      final items = IList.fromJson(
        data,
        (json) => {{name.pascalCase()}}Model.fromJson(json as Map<String, dynamic>),
      );
      return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}Model>> findOne({{name.pascalCase()}}Id id) async{
   return await errorHandler(() async {
   final query = _ref.supabaseClient
   .from({{name.pascalCase()}}Model.table.tableName)
   .select({{name.pascalCase()}}Model.table.selectStatement)
   .eq({{name.pascalCase()}}Table.id, id.value);
   
   final result = await query.single();
   return right({{name.pascalCase()}}Model.fromJson(result));
   });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findPagination({
    required int limit,
    required int offset,
    required {{name.pascalCase()}}ListParam param,
  }) async{
    return await errorHandler(() async {
      var query = _ref.supabaseClient.from({{name.pascalCase()}}Model.table.tableName).select({{name.pascalCase()}}Model.table.selectStatement);
    
    if (true) {}
    
    return await query
    .limit(limit)
    .range(offset, offset + limit)
    .withConverter((data) {
      final items = IList.fromJson(
        data,
        (json) => {{name.pascalCase()}}Model.fromJson(json as Map<String, dynamic>),
      );
      return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}Model>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required {{name.pascalCase()}}UpdateParam data}) async{
    return await errorHandler(() async {
    return await _ref.supabaseClient
    .from({{name.pascalCase()}}Model.table.tableName)
    .update(data.toJson())
    .eq({{name.pascalCase()}}Table.id, {{name.camelCase()}}Id.value)
    .select({{name.pascalCase()}}Model.table.selectStatement)
    .single()
    .withConverter((data) => right({{name.pascalCase()}}Model.fromJson(data)));
    });
  }
}
