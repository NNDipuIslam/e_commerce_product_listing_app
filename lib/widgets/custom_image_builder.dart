import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;
  final Alignment alignment;
  final Color? color;
  final String? semanticsLabel;
  final Gradient? gradient;
  final double? borderRadius; // New borderRadius parameter

  const CustomImageWidget({
    Key? key,
    required this.imagePath,
    this.width = 100.0,
    this.height = 100.0,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.color,
    this.semanticsLabel,
    this.gradient,
    this.borderRadius, // Pass borderRadius from constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imagePath.endsWith('.svg')) {
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
      imageWidget = CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    } else {
      imageWidget = Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
      );
    }

    // Wrap with Container to apply gradient and ClipRRect for borderRadius
    return Container(
      width: width,
      height: height,
      decoration: gradient != null
          ? BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: imageWidget,
      ),
    );
  }
}
