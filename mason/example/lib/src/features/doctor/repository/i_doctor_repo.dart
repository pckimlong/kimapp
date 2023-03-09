


import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core.dart';
import '../../../../exports.dart';

part 'i_doctor_repo.g.dart';


@Riverpod(keepAlive: true)
IDoctorRepo doctorRepo(DoctorRepoRef ref) => _Impl(ref);


abstract class IDoctorRepo {
  Future<Either<Failure, IList<DoctorModel>>> findAll(DoctorListParam param);

  Future<Either<Failure, DoctorDetailModel>> findOne(DoctorId doctorId);

  Future<Either<Failure, DoctorDetailModel>> create(CreateDoctorParam data);

  Future<Either<Failure, DoctorDetailModel>> update(DoctorId doctorId ,{required UpdateDoctorParam data});

  Future<Either<Failure, Unit>> delete(DeleteDoctorParam param);

  Future<Either<Failure, DoctorListPaginationResponse>> findPagination({
    required int limit,
    required int offset,
    required DoctorListPaginationParam param,
  });
}



class _Impl implements IDoctorRepo {
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
