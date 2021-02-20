import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    @required this.text,
    this.size,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.justify,
    this.maxLine = 2,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
