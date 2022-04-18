import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String message,
    {String title = "Error",
    boolisError = true,
    Color color = Colors.redAccent}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      color: Colors.white,
    ),
    messageText: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: color.withOpacity(.5),
  );
}
