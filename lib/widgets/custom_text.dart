import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text; // The text to display
  final TextAlign textAlign; // Text alignment
  final TextOverflow overflow; // Text overflow behavior
  final int? maxLines; // The maximum number of lines to show
  final bool softWrap; // Whether the text should break at soft line breaks
  final TextDirection? textDirection; // The direction of the text
  final Locale? locale; // The locale of the text
  final TextHeightBehavior? textHeightBehavior; // Behavior for text height
  final TextWidthBasis? textWidthBasis; // Basis for measuring the text's width
  
  // TextStyle Parameters
  final Color? color; // Text color
  final double? fontSize; // Font size
  final FontWeight? fontWeight; // Font weight
  final FontStyle? fontStyle; // Font style (normal or italic)
  final double? letterSpacing; // Letter spacing
  final double? wordSpacing; // Word spacing
  final TextBaseline? textBaseline; // Text baseline for vertical alignment
  final Locale? textLocale; // Text locale
  final double? height; // Line height
  final String? fontFamily; // Font family
  final List<FontFeature>? fontFeatures; // Font features (e.g., ligatures)
  
  // Constructor to initialize text and styling options
  const CustomText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textHeightBehavior,
    this.textWidthBasis,
    
    // TextStyle parameters
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.textLocale,
    this.height,
    this.fontFamily,
    this.fontFeatures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textDirection: textDirection,
      locale: locale,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        fontFamily: fontFamily,
        fontFeatures: fontFeatures,
      ),
    );
  }
}
