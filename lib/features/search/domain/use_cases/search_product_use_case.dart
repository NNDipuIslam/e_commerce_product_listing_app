import 'package:dartz/dartz.dart';

import 'package:e_commerce_product_listing_app/core/exports.dart';

class SearchProduct {
  final ProductRepository repository;

  SearchProduct(this.repository);

  Future<Either<Failure, List<Product>>> call({required String query, int skip = 0, int limit = 10}) {
    return repository.searchProduct(query: query, skip: skip, limit: limit);
  }
}
