import 'package:e_commerce_product_listing_app/core/exports.dart';

enum AvailabilityStatus {
  inStock,
  lowStock,
  outOfStock,
}

class Product {
  int? id;
  String? title;
  double? price;
  double? discountPercentage;
  double? rating;
  List<String>? images;
  List<ReviewModel>? reviews;
  AvailabilityStatus? availabilityStatus;

  Product({
    this.id,
    this.title,
    this.price,
    this.discountPercentage,
    this.rating,
    this.images,
    this.reviews,
    this.availabilityStatus,
  });
}
