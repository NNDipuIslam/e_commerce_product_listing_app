import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? borderColor;
  final bool enabled;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDense;

  // Constructor with all parameters
  const CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.contentPadding,
    this.margin,
    this.cursorColor,
    this.fillColor,
    this.borderColor,
    this.enabled = true,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: textStyle,
        textAlign: textAlign,
        obscureText: obscureText,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        maxLines: maxLines,
        minLines: minLines,
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
      //  contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        cursorColor: cursorColor,
        enabled: enabled,
        autofocus: autofocus,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          fillColor: fillColor,
          filled: fillColor != null,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? Colors.blue, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          isDense: isDense,
        ),
      ),
    );
  }
}
