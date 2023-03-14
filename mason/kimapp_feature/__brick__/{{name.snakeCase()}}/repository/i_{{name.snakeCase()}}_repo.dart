// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import '../../../../exports.dart';
import '../model/models.dart';
import '../param/params.dart';

part 'i_{{name.snakeCase()}}_repo.g.dart';


@Riverpod(keepAlive: true)
I{{name.pascalCase()}}Repo {{name.camelCase()}}Repo({{name.pascalCase()}}RepoRef ref) => _Impl(ref);


abstract class I{{name.pascalCase()}}Repo {
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll({{name.pascalCase()}}ListParam param);

  Future<Either<Failure, {{name.pascalCase()}}DetailModel>> findOne({{name.pascalCase()}}Id {{name.camelCase()}}Id);

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
  Future<Either<Failure,  {{name.pascalCase()}}DetailModel>> create(Create{{name.pascalCase()}}Param data) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, Unit>> delete(Delete{{name.pascalCase()}}Param param) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findAll({{name.pascalCase()}}ListParam param) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}DetailModel>> findOne({{name.pascalCase()}}Id {{name.camelCase()}}Id) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, IList<{{name.pascalCase()}}Model>>> findPagination({
    required int limit,
    required int offset,
    required {{name.pascalCase()}}ListPaginationParam param,
  }) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure,  {{name.pascalCase()}}DetailModel>> update({{name.pascalCase()}}Id {{name.camelCase()}}Id ,{required Update{{name.pascalCase()}}Param data}) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }
}
