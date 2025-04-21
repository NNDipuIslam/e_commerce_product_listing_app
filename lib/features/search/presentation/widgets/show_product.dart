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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Discounted Price
        Text(
          discountedPrice,
          style: TextStyle(
            fontSize: 14.sp, // responsive font size
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 10.w),
        // Original Price (strikethrough)
        Text(
          originalPrice,
          style: TextStyle(
            fontSize: 10.sp, // responsive font size
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        SizedBox(width: 10.w),
        // Discount Percentage
        Text(
          discount,
          style: TextStyle(
            fontSize: 10.sp, // responsive font size
            color: AppPalette.warning,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 20.w),
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

// Main Product Widget
Widget showProduct({required BuildContext context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomImageWidget(
        height: 164.h, // responsive height
        width: double.infinity,
        fit: BoxFit.cover,
        borderRadius: 4.r, // responsive border radius
        imagePath: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      ),
      const SizedBox(height: 8),
      ProductTitle(title: 'Allen Solly Regular fit cotton shirt'),
      const SizedBox(height: 8),
      PriceRow(
        discountedPrice: '\$35',
        originalPrice: '\$40.25',
        discount: '15% OFF',
      ),
      const SizedBox(height: 8),
      ProductRating(rating: 4.3, reviews: 41),
    ],
  );
}
