import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/features/search/data/models/availability_status.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends Product {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final double? price;

  @HiveField(3)
  final double? discountPercentage;

  @HiveField(4)
  final double? rating;

  @HiveField(5)
  final String? thumbnail;

  @HiveField(6)
  final List<ReviewModel>? reviews;

  @HiveField(7)
  final AvailabilityStatus? availabilityStatus;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.discountPercentage,
    this.rating,
    this.thumbnail,
    this.reviews,
    this.availabilityStatus,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] as int?,
        title: json["title"] as String?,
        price: (json["price"] as num?)?.toDouble(),
        discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),
        rating: (json["rating"] as num?)?.toDouble(),
        thumbnail: json["thumbnail"] as String?,
        reviews: (json["reviews"] as List<dynamic>?)
                ?.map((x) => ReviewModel.fromJson(x))
                .toList() ??
            [],
        availabilityStatus:
            availabilityStatusValues[json["availabilityStatus"]] ??
                AvailabilityStatus.outOfStock,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "images": images,
        "reviews": reviews?.map((x) => x.toJson()).toList(),
        "availabilityStatus": availabilityStatusValues.entries
            .firstWhere((entry) => entry.value == availabilityStatus)
            .key,
      };
}
