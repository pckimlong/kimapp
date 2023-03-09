
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exports.dart';

part 'i_product_repo.g.dart';


@Riverpod(keepAlive: true)
IProductRepo productRepo(ProductRepoRef ref) => _Impl(ref);


abstract class IProductRepo {
  Future<Either<Failure, ProductModel>> findAll(ProductListParam param);

  Future<Either<Failure, ProductDetailModel>> findOne(ProductId Id);

  Future<Either<Failure, ProductDetailModel>> create(CreateProductParam data);

  Future<Either<Failure, ProductDetailModel>> update(ProductId Id ,{required UpdateProductParam data});

  Future<Either<Failure, Unit>> delete(DeleteProductParam param);

  Future<Either<Failure, ProductListPaginationResponse>> findPagination({
    required int limit,
    required int offset,
    required ProductListPaginationParam param,
  });
}
