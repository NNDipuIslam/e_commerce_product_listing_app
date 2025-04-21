import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImageWidget extends StatelessWidget {
  final String
      imagePath; // The path of the image (can be an asset or network URL)
  final double width; // The width of the image
  final double height; // The height of the image
  final BoxFit
      fit; // The fit of the image (BoxFit contains different types of scaling, like fill, contain, etc.)
  final Alignment alignment; // The alignment of the image
  final Color? color; // The color to blend with the image (for tinting)
  final String? semanticsLabel; // Accessibility label for the image
  final Gradient? gradient; // The gradient to apply to the image

  // Constructor to initialize image path, width, height, and all new parameters
  const CustomImageWidget({
    Key? key,
    required this.imagePath,
    this.width = 100.0,
    this.height = 100.0,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.color,
    this.semanticsLabel,
    this.gradient, // New parameter for gradient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    // Check if the image is an SVG by checking the file extension
    if (imagePath.endsWith('.svg')) {
      // Use SvgPicture to load SVG images
      imageWidget = SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        semanticsLabel: semanticsLabel,
      );
    } else if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      // Use CachedNetworkImage for network images
      imageWidget = CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        placeholder: (context, url) =>
            CircularProgressIndicator(), // Placeholder while loading
        errorWidget: (context, url, error) =>
            Icon(Icons.error), // Error icon when image fails to load
      );
    } else {
      // Use Image.asset for non-SVG asset images (like PNG, JPG, etc.)
      imageWidget = Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
      );
    }

    // Return the image widget without any gradient if none is provided
    return imageWidget;
  }
}
