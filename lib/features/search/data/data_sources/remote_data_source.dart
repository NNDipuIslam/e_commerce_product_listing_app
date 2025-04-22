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

// Check if the response contains data
      if (response.statusCode == 200) {
        final data = response.data; // Get the data from the response

        // Log the entire response to inspect the structure

        // Make sure 'data' has the 'products' key before attempting to parse
        if (data != null && data['products'] != null) {
          List<ProductModel> productsList = List<ProductModel>.from(
            data['products'].map((e) => ProductModel.fromJson(e)),
          );

          // Return the mapped list of ProductModel objects
          return productsList;
        } else {
          // Handle the case when 'products' is not in the response
          print('No products found in the response');
          return [];
        }
      } else {
        // Handle unsuccessful responses
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
