import 'package:flutter/material.dart';

class FFButtonWidget extends StatelessWidget {
  const FFButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.options,
  });

  final String text;
  final Widget? icon;
  final VoidCallback onPressed;
  final FFButtonOptions? options;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: options?.color,
        textStyle: options?.textStyle,
        elevation: options?.elevation,
        padding: options?.padding,
      ),
      child: Text(text),
    );
  }
}

class FFButtonOptions {
  const FFButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
}
