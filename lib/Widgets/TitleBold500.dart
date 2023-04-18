import 'package:flutter/material.dart';

class TitleBold500 extends StatelessWidget {
  final String title,fontFamily;
  final Color titleColor;
  final double fontSize;
  final int maxLines;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  const TitleBold500({super.key,
    this.title = "",
    this.fontFamily = 'DMSans',
    this.titleColor = Colors.black,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.maxLines = 2,
    this.textAlign = TextAlign.left, this.overflow, this.textDecoration=TextDecoration.none,
  }); //11

  @override
  Widget build(BuildContext context) {
    return Text(title,
        maxLines: maxLines,
        style: TextStyle(
          fontFamily: fontFamily,
          color: titleColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: FontStyle.normal,
          overflow: overflow,
          decoration: textDecoration,
          letterSpacing: 0.3,
        ),
        textAlign: textAlign);
  }
}