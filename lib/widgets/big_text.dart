import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color color;
  double size;
  TextOverflow Overflow;
  BigText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF89dad0),
      this.size = 0,
      this.Overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: Overflow,
      style: TextStyle(
          fontFamily: "Roboto",
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontWeight: FontWeight.w400),
    );
  }
}
