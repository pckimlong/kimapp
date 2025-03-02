import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kimapp/kimapp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kimapp_supabase_helper/kimapp_supabase_helper.dart';

import 'params/test_feature_list_param.dart';
import 'test_feature_schema.schema.dart';

part 'i_test_feature_repo.g.dart';


@Riverpod(keepAlive: true)
ITestFeatureRepo testFeatureRepo(Ref ref) => _Impl(ref);


abstract class ITestFeatureRepo {
  Future<Either<Failure, IList<TestFeatureModel>>> findAll(TestFeatureListParam param);

  Future<Either<Failure, TestFeatureModel>> findOne(TestFeatureId id);

  Future<Either<Failure, TestFeatureModel>> create(TestFeatureCreateParam data);

  Future<Either<Failure, TestFeatureModel>> update(TestFeatureId testFeatureId ,{required TestFeatureUpdateParam data});

  Future<Either<Failure, Unit>> delete(TestFeatureId id);

  Future<Either<Failure, IList<TestFeatureModel>>> findPagination({
    required int limit,
    required int offset,
    required TestFeatureListParam param,
  });
}



class _Impl implements ITestFeatureRepo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure,  TestFeatureModel>> create(TestFeatureCreateParam data) async{
   return await errorHandler(() async {
   return await _ref.supabaseClient
    .from(TestFeatureModel.table.tableName)
    .insert(data.toJson())
    .select(TestFeatureModel.table.selectStatement)
    .single()
    .withConverter((data) => right(TestFeatureModel.fromJson(data)));
   });
  }

  @override
  Future<Either<Failure, Unit>> delete(TestFeatureId id) async{
    return await errorHandler(() async {
    await _ref.supabaseClient
    .from(TestFeatureTable.table)
    .delete()
    .eq(TestFeatureTable.id, id.value);
    
    return right(unit);
    });
  }

  @override
  Future<Either<Failure, IList<TestFeatureModel>>> findAll(TestFeatureListParam param) async{
    return await errorHandler(() async {
    var query = _ref.supabaseClient.from(TestFeatureModel.table.tableName).select(TestFeatureModel.table.selectStatement);
    
    if (true) {}
    
    return await query.withConverter((data) {
      final items = IList.fromJson(
        data,
        (json) => TestFeatureModel.fromJson(json as Map<String, dynamic>),
      );
      return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  TestFeatureModel>> findOne(TestFeatureId id) async{
   return await errorHandler(() async {
   final query = _ref.supabaseClient
   .from(TestFeatureModel.table.tableName)
   .select(TestFeatureModel.table.selectStatement)
   .eq(TestFeatureTable.id, id.value);
   
   final result = await query.single();
   return right(TestFeatureModel.fromJson(result));
   });
  }

  @override
  Future<Either<Failure, IList<TestFeatureModel>>> findPagination({
    required int limit,
    required int offset,
    required TestFeatureListParam param,
  }) async{
    return await errorHandler(() async {
      var query = _ref.supabaseClient.from(TestFeatureModel.table.tableName).select(TestFeatureModel.table.selectStatement);
    
    if (true) {}
    
    return await query
    .limit(limit)
    .range(offset, offset + limit)
    .withConverter((data) {
      final items = IList.fromJson(
        data,
        (json) => TestFeatureModel.fromJson(json as Map<String, dynamic>),
      );
      return right(items);
    });
    });
  }

  @override
  Future<Either<Failure,  TestFeatureModel>> update(TestFeatureId testFeatureId ,{required TestFeatureUpdateParam data}) async{
    return await errorHandler(() async {
    return await _ref.supabaseClient
    .from(TestFeatureModel.table.tableName)
    .update(data.toJson())
    .eq(TestFeatureTable.id, testFeatureId.value)
    .select(TestFeatureModel.table.selectStatement)
    .single()
    .withConverter((data) => right(TestFeatureModel.fromJson(data)));
    });
  }
}
