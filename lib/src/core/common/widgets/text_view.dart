
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlignment;
  final TextOverflow? overflow;
  final TextDirection? textDirection;

  const TextView({
    Key? key,
    required this.text,
    this.maxLines,
    this.style,
    this.overflow,
    this.textAlignment,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
      textAlign: textAlignment,
    );
  }
}
