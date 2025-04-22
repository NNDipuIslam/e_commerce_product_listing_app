import 'package:e_commerce_product_listing_app/core/exports.dart';



abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int skip, int limit});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService apiService;

  ProductRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 10}) async {
    try {
      final response = await apiService.get(
        '/products',
        queryParams: {
          'skip': skip,
          'limit': limit,
        },
      );

      final data = response.data;
      return List<ProductModel>.from(
        data['products'].map((x) => ProductModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
