import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(Duration(milliseconds: 1500),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  Future<void> _loadResources() async {
    // await Get.find<CartController>();
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,
              ),
            ),
            Image.asset("assets/image/logo part 2.png",
                width: Dimensions.splashImg)
          ],
        ),
      ),
    );
  }
}
