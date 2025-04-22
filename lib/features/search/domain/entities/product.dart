import 'package:e_commerce_product_listing_app/core/exports.dart';

enum AvailabilityStatus {
  inStock,
  lowStock,
  outOfStock,
}

abstract class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? thumbnail;
  final double? discountPercentage;
  final double? rating;
  final List<String>? images;
  final List<ReviewModel>? reviews;
  final AvailabilityStatus? availabilityStatus;

  Product({
    this.id,
    this.title,
    this.price,
    this.thumbnail,
    this.discountPercentage,
    this.rating,
    this.images,
    this.reviews,
    this.availabilityStatus,
  });
}
