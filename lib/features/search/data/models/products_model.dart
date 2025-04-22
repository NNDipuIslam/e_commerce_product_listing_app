import 'package:hive/hive.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';

part 'products_model.g.dart';


@HiveType(typeId: 0)
class ProductsModel {
  @HiveField(0)
  final List<ProductModel>? products;

  @HiveField(1)
  final int? total;

  @HiveField(2)
  final int? skip;

  @HiveField(3)
  final int? limit;

  ProductsModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: (json["products"] as List<dynamic>?)
                ?.map((x) => ProductModel.fromJson(x))
                .toList() ??
            [],
        total: json["total"] as int?,
        skip: json["skip"] as int?,
        limit: json["limit"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "products": products?.map((x) => x.toJson()).toList(),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}
