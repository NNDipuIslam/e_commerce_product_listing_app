import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Product Title Widget
class ProductTitle extends StatelessWidget {
  final String title;

  const ProductTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      fontSize: 12.sp, // responsive font size
      fontWeight: FontWeight.w400,
    );
  }
}

// Price Row Widget
class PriceRow extends StatelessWidget {
  final String discountedPrice;
  final String originalPrice;
  final String discount;

  const PriceRow({
    required this.discountedPrice,
    required this.originalPrice,
    required this.discount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Discounted Price
        Flexible(
          flex: 2,
          child: Text(
            discountedPrice,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(width: 6.w),

        // Original Price (strikethrough)
        if (originalPrice.isNotEmpty)
          Flexible(
            flex: 2,
            child: Text(
              originalPrice,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        SizedBox(width: 6.w),

        // Discount Percentage
        if (discount.isNotEmpty)
          Flexible(
            flex: 2,
            child: Text(
              discount,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppPalette.warning,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}


// Rating Widget
class ProductRating extends StatelessWidget {
  final double rating;
  final int reviews;

  const ProductRating({required this.rating, required this.reviews, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        customRating(),
        SizedBox(width: 5.w),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 12.sp, // responsive font size
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          '($reviews)',
          style: TextStyle(
            fontSize: 12.sp, // responsive font size
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ImageWithFavourite extends StatefulWidget {
  final String imagePath;

  const ImageWithFavourite({required this.imagePath, Key? key})
      : super(key: key);

  @override
  _ImageWithFavouriteState createState() => _ImageWithFavouriteState();
}

class _ImageWithFavouriteState extends State<ImageWithFavourite> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
  height: 164.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
    color: AppPalette.imageBackground, // Background color for the image area
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12.r),
    child: Image.network(
      widget.imagePath,
      height: 164.h,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
)

        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: CircleAvatar(
            radius: 16.r,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black54,
                size: 20.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Main Product Widget
Widget showProduct({required BuildContext context, required Product product}) {
  final double price = product.price ?? 0;
  final double discount = product.discountPercentage ?? 0;
  final double discountedPrice = price - (price * discount / 100);

  final bool hasDiscount = discount > 0;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ImageWithFavourite(
        imagePath: product.thumbnail ??
            "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      ),
      const SizedBox(height: 8),
      ProductTitle(title: product.title ?? 'Unknown product'),
      const SizedBox(height: 8),
      hasDiscount
          ? PriceRow(
              discountedPrice: '\$${discountedPrice.toStringAsFixed(2)}',
              originalPrice: '\$${price.toStringAsFixed(2)}',
              discount: '${discount.toStringAsFixed(0)}% OFF',
            )
          : PriceRow(
              discountedPrice: '\$${price.toStringAsFixed(2)}',
              originalPrice: '',
              discount: '',
            ),
      const SizedBox(height: 8),
      ProductRating(
          rating: product.rating ?? 0, reviews: product.reviews?.length ?? 0),
    ],
  );
}
