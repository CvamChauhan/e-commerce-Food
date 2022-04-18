import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  String hintText;
  TextEditingController controller;
  bool isObscure;
  TextFieldWidget(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.controller,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width45),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(1, 5),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        obscureText: isObscure,
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColors.mainColor,
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
