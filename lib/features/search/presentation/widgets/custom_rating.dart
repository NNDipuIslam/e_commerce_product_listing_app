import 'package:e_commerce_product_listing_app/core/constants/app_pallete.dart';
import 'package:flutter/material.dart';

Widget customRating() {
  return Container(
    padding: EdgeInsets.all(2),
    decoration: BoxDecoration(
        color: AppPalette.yellow_500, borderRadius: BorderRadius.circular(2)),
    child: Center(
      child: Icon(
        Icons.star,
        color: AppPalette.white,
      ),
    ),
  );
}
