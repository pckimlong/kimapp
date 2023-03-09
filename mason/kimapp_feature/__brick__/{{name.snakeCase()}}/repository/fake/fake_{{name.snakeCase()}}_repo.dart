

class Fake{{name.pascalCase()}}Repo implements I{{name.pascalCase()}}Repo {
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
  Future<Either<Failure, {{name.pascalCase()}}ListPaginationResponse>> findPagination({
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
