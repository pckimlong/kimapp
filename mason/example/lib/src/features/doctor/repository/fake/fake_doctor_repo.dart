

class FakeDoctorRepo implements IDoctorRepo {
  _Impl(this._ref);

  final Ref _ref;

  @override
  Future<Either<Failure,  DoctorDetailModel>> create(CreateDoctorParam data) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, Unit>> delete(DeleteDoctorParam param) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, IList<DoctorModel>>> findAll(DoctorListParam param) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure,  DoctorDetailModel>> findOne(DoctorId doctorId) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure, DoctorListPaginationResponse>> findPagination({
    required int limit,
    required int offset,
    required DoctorListPaginationParam param,
  }) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }

  @override
  Future<Either<Failure,  DoctorDetailModel>> update(DoctorId doctorId ,{required UpdateDoctorParam data}) {
    return errorHandler(() async {
      throw UnimplementedError();
    });
  }
}
