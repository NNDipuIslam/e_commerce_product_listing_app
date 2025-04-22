import 'package:dartz/dartz.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/features/search/data/data_sources/local_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;

  ProductRepositoryImpl(
      {required this.productRemoteDataSource,
      required this.productLocalDataSource});
  @override
  Future<Either<Failure, List<Product>>> getProducts(
      {int skip = 0, int limit = 10}) async {
    try {
      final products =
          await productRemoteDataSource.getProducts(skip: skip, limit: limit);
      List<Product> productsWithoutJson =
          products.map((e) => e as Product).toList();
      return Right(productsWithoutJson);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
