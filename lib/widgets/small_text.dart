import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  String text;
  Color color;
  double? size;
  double? height;
  SmallText({
    Key? key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 12,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "Roboto",
          color: color,
          fontSize: size == 0 ? Dimensions.font12 : size,
          height: height),
    );
  }
}
