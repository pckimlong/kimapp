import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../../../exports.dart';
import '../models/models.dart';
import '../params/params.dart';

part 'i_{{name.snakeCase()}}_repo.g.dart';


@Riverpod(keepAlive: true)
I{{name.pascalCase()}}Repo {{name.camelCase()}}Repo({{name.pascalCase()}}RepoRef ref) => _Impl(ref);


abstract class I{{name.pascalCase()}}Repo {
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll({{name.pascalCase()}}ListParam param);

  Future<Either<Failure, {{name.pascalCase()}}DetailModel>> findOne(FindOne{{name.pascalCase()}}Param param);

  Future<Either<Failure, {{name.pascalCase()}}DetailModel>> create(Create{{name.pascalCase()}}Param data);

  Future<Either<Failure, {{name.pascalCase()}}DetailModel>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required Update{{name.pascalCase()}}Param data});

  Future<Either<Failure, Unit>> delete(Delete{{name.pascalCase()}}Param param);

  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findPagination({
    required int limit,
    required int offset,
    required {{name.pascalCase()}}ListPaginationParam param,
  });
}



class _Impl implements I{{name.pascalCase()}}Repo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure,  {{name.pascalCase()}}DetailModel>> create(Create{{name.pascalCase()}}Param data) async{
   return await errorHandler(() async {
   return await _ref
    .read(supabaseProvider)
    .client
    .from({{name.pascalCase()}}DetailModel.table.tableName)
    .insert(data.toJson())
    .select({{name.pascalCase()}}DetailModel.table.selectStatement)
    .single()
    .withConverter((data) => right({{name.pascalCase()}}DetailModel.fromJson(data)));
   });
  }

  @override
  Future<Either<Failure, Unit>> delete(Delete{{name.pascalCase()}}Param param) async{
    return await errorHandler(() async {
    await _ref
    .read(supabaseProvider)
    .client
    .from({{name.pascalCase()}}Table.table)
    .delete()
    .eq({{name.pascalCase()}}Table.id, param.{{name.camelCase()}}Id.value);
    
    return right(unit);
    });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll({{name.pascalCase()}}ListParam param) async{
    return await errorHandler(() async {
    var query = _ref.supabaseClient.from({{name.pascalCase()}}Model.table.tableName).select({{name.pascalCase()}}Model.table.selectStatement);
    
    if (true) {}
    
    return await query.withConverter((data) {
    final items = (data as List<dynamic>).map((e) => {{name.pascalCase()}}Model.fromJson(e)).toIList();
    return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}DetailModel>> findOne(FindOne{{name.pascalCase()}}Param param) async{
   return await errorHandler(() async {
   var query = _ref
   .read(supabaseProvider)
   .client
   .from({{name.pascalCase()}}DetailModel.table.tableName)
   .select({{name.pascalCase()}}DetailModel.table.selectStatement);
   
   query = param.when(
    byId: (id) => query.eq({{name.pascalCase()}}Table.id, id.value),
   );
   
   final result = await query.single();
   return right({{name.pascalCase()}}DetailModel.fromJson(result));
   });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findPagination({
    required int limit,
    required int offset,
    required {{name.pascalCase()}}ListPaginationParam param,
  }) async{
    var query = _ref.supabaseClient.from({{name.pascalCase()}}Model.table.tableName).select({{name.pascalCase()}}Model.table.selectStatement);
    
    if (true) {}
    
    return await query
    .limit(limit)
    .range(offset, offset + limit)
    .withConverter((data) {
    final items = (data as List<dynamic>).map((e) => {{name.pascalCase()}}Model.fromJson(e)).toIList();
    return right(items);
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}DetailModel>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required Update{{name.pascalCase()}}Param data}) async{
    return await errorHandler(() async {
    return await _ref
    .read(supabaseProvider)
    .client
    .from({{name.pascalCase()}}DetailModel.table.tableName)
    .update(data.toJson())
    .eq({{name.pascalCase()}}Table.id, {{name.camelCase()}}Id.value)
    .select({{name.pascalCase()}}DetailModel.table.selectStatement)
    .single()
    .withConverter((data) => right({{name.pascalCase()}}DetailModel.fromJson(data)));
    });
  }
}
