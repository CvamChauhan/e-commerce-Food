import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/helper/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_with_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: .86);
  double? page = 0;
  int totalPage = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        page = pageController.page;
      });
    });
  }

  void auto() {
    Timer(const Duration(seconds: 4), () {
      if ((page!.toInt() + 1) % totalPage == 0) {
        pageController.jumpToPage(0);
      } else {
        pageController.animateToPage(page!.toInt() + 1,
            duration: const Duration(seconds: 2), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.removeListener(() {});
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          totalPage = popularProducts.PopularProductList.length;
          return popularProducts.isLoaded
              ? Container(
                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                  height: Dimensions.pageView,
                  width: double.maxFinite,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.PopularProductList.isEmpty
                        ? 1
                        : popularProducts.PopularProductList.length,
                    itemBuilder: (context, index) {
                      return _buildPageItems(
                          index, popularProducts.PopularProductList[index]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.PopularProductList.isEmpty
                ? 1
                : popularProducts.PopularProductList.length,
            position: page!,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(
              text: "Recommended",
              color: AppColors.mainBlackColor,
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: 3,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: SmallText(
                text: ".",
                color: Colors.black26,
                size: 25,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 3),
              child: SmallText(
                text: "Food pairing",
                color: Colors.black26,
              ),
            ),
          ]),
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProducts) {
          return recommendedProducts.isLoaded
              ? Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height30),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          recommendedProducts.RecommendedProductList.length,
                      itemBuilder: (BuildContext context, index) {
                        ProductModel recommendedProduct =
                            recommendedProducts.RecommendedProductList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getrecommendedFood(index));
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height20),
                                height: Dimensions.listViewImgSize,
                                width: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              recommendedProduct.img!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10,
                                      bottom: Dimensions.height20),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20,
                                      vertical: Dimensions.height10),
                                  height: Dimensions.PageViewTextContainer,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: recommendedProduct.name!,
                                        color: AppColors.mainBlackColor,
                                      ),
                                      SmallText(
                                        text: "With Indian characteristics",
                                        color: Colors.black26,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPageItems(int index, ProductModel popularProduct) {
    double offset = 0;
    double scale = 1;
    if (index == page) {
      // auto();
      offset = 0;
    } else if (index > page!) {
      offset = (index - page!);
      scale = scale - (offset / 4);
    } else {
      offset = (page! - index);
      scale = scale - (offset / 4);
    }

    return Transform(
      origin: Offset(0, offset * 120),
      transform: Matrix4.diagonal3Values(1, scale, 1),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(index));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.PageViewContainer,
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img!),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(
                      bottom: Dimensions.height10,
                      left: Dimensions.height35,
                      right: Dimensions.height35),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width45,
                      vertical: Dimensions.height15),
                  height: Dimensions.PageViewTextContainer,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(
                              0,
                              5,
                            ),
                            color: Colors.black26,
                            blurRadius: 5),
                        BoxShadow(
                          offset: Offset(-5, 0),
                          color: Colors.white,
                        ),
                        BoxShadow(
                          offset: Offset(5, 0),
                          color: Colors.white,
                        )
                      ]),
                  child: AppColumn(
                    text: popularProduct.name!,
                    color: Colors.black,
                    size: Dimensions.font12 * 2,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
