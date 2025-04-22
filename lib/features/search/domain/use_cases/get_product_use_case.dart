import 'package:dartz/dartz.dart';

import 'package:e_commerce_product_listing_app/core/exports.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> call({int skip = 0, int limit = 10}) {
    return repository.getProducts(skip: skip, limit: limit);
  }
}
