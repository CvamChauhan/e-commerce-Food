import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  double iconSize;
  double textSize;
  Color iconColor;
  Color textColor;
  IconWithText({
    Key? key,
    required this.icon,
    required this.text,
    this.iconSize = 0,
    this.textSize = 0,
    this.iconColor = Colors.black,
    this.textColor = const Color(0xFF332d2b),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize == 0 ? Dimensions.iconSize20 : iconSize,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Roboto",
            color: textColor,
            fontSize: textSize == 0 ? Dimensions.font12 : textSize,
          ),
        ),
      ],
    );
  }
}
