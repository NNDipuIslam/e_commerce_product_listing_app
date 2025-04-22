import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:hive/hive.dart';

class ProductLocalDataSource {
  final Box<Product> _productBox;

  ProductLocalDataSource(this._productBox);

  // Save a product to Hive
  Future<void> saveProduct(Product product) async {
    await _productBox.put(product.id, product);
  }

  // Fetch a product by ID
  Product? getProduct(String productId) {
    return _productBox.get(productId);
  }

  // Fetch all products
  List<Product> getAllProducts() {
    return _productBox.values.toList();
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    await _productBox.delete(productId);
  }

  // Clear all stored products
  Future<void> clearAllProducts() async {
    await _productBox.clear();
  }

  // Close the box (usually on app exit or test teardown)
  Future<void> close() async {
    await _productBox.close();
  }
}
