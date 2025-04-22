import 'package:dartz/dartz.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(
      {int skip = 0, int limit = 10});
  Future<Either<Failure, List<Product>>> searchProduct(
      {required String query, int skip = 0, int limit = 10});
}
