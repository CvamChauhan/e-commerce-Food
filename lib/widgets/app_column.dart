import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_with_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const AppColumn(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF89dad0),
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BigText(
          text: text,
          color: color,
          size: size,
        ),
        SizedBox(
          width: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: Dimensions.iconSize20,
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width15,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: Dimensions.height10,
            ),
            SmallText(text: "128 comments")
          ],
        ),
        SizedBox(
          width: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWithText(
              icon: Icons.circle,
              text: "Nornal",
              iconColor: Colors.yellow,
            ),
            IconWithText(
              icon: Icons.location_on,
              text: "6.1KM",
              iconColor: AppColors.mainColor,
            ),
            IconWithText(
              icon: Icons.timelapse_sharp,
              text: "32mins",
              iconColor: Colors.purple,
            )
          ],
        ),
      ],
    );
  }
}
