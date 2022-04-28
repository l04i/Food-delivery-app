import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color color;
  double size;
  TextOverflow textOverflow;

  BigText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    this.textOverflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
          color: color,
          fontSize: size==0? Dimensions.font20 : size,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400),
    );
  }
}
