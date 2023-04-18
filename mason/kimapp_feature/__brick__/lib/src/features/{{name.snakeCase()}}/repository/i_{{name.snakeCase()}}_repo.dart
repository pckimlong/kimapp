import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../../../exports.dart';
import '../model/models.dart';
import '../param/params.dart';

part 'i_{{name.snakeCase()}}_repo.g.dart';


@Riverpod(keepAlive: true)
I{{name.pascalCase()}}Repo {{name.camelCase()}}Repo({{name.pascalCase()}}RepoRef ref) => _Impl(ref);


abstract class I{{name.pascalCase()}}Repo {
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll({{name.pascalCase()}}ListParam param);

  Future<Either<Failure, {{name.pascalCase()}}Model>> findOne(FindOne{{name.pascalCase()}}Param param);

  Future<Either<Failure, {{name.pascalCase()}}Model>> create(Create{{name.pascalCase()}}Param data);

  Future<Either<Failure, {{name.pascalCase()}}Model>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required Update{{name.pascalCase()}}Param data});

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
  Future<Either<Failure,  {{name.pascalCase()}}Model>> create(Create{{name.pascalCase()}}Param data) async{
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, Unit>> delete(Delete{{name.pascalCase()}}Param param) async{
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll({{name.pascalCase()}}ListParam param) async{
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}Model>> findOne(FindOne{{name.pascalCase()}}Param param) async{
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findPagination({
    required int limit,
    required int offset,
    required {{name.pascalCase()}}ListPaginationParam param,
  }) async{
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}Model>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required Update{{name.pascalCase()}}Param data}) async{
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }
}
