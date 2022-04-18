import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final void Function()? ontap;
  AppIcon(
      {Key? key,
      required this.iconData,
      this.iconColor = const Color(0xFF756d54),
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.size = 0,
      this.iconSize = 20,
      this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      splashColor: Colors.black,
      highlightColor: Colors.black38,
      borderRadius:
          BorderRadius.circular(size == 0 ? Dimensions.height35 : size / 2),
      child: Container(
          height: size == 0 ? Dimensions.height35 : size,
          width: size == 0 ? Dimensions.height35 : size,
          decoration: BoxDecoration(
              color: backgroundColor.withOpacity(.8),
              borderRadius: BorderRadius.circular(
                  size == 0 ? Dimensions.height35 : size / 2)),
          child: Center(
            child: Icon(
              iconData,
              size: iconSize,
              color: iconColor,
            ),
          )),
    );
  }
}
