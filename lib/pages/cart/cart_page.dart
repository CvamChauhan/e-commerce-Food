import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/location_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/helper/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.find<PopularProductController>();
    // Get.find<UserController>().getUserInfo();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height10,
              left: Dimensions.width30,
              right: Dimensions.width30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    iconData: Icons.arrow_back_ios,
                    ontap: () {
                      Get.back();
                    },
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                  SizedBox(
                    width: Dimensions.width45,
                  ),
                  AppIcon(
                    iconData: Icons.home_outlined,
                    ontap: () {
                      Get.offNamedUntil(RouteHelper.initial,
                          (route) => Get.currentRoute == RouteHelper.initial);
                    },
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return Stack(
                        children: <Widget>[
                          AppIcon(
                            iconData: Icons.shopping_cart,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                          ),
                          controller.totalItems > 0
                              ? Positioned(
                                  top: 2.0,
                                  right: 2,
                                  child: Icon(
                                    Icons.circle,
                                    size: 18,
                                    color: Colors.grey.shade50,
                                  ),
                                )
                              : Container(),
                          controller.totalItems > 0
                              ? Positioned(
                                  top: 4.0,
                                  right: 5.0,
                                  child: Center(
                                    child: Text(
                                      controller.totalItems.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height30 * 2,
                      left: Dimensions.width30,
                      right: Dimensions.width30,
                      bottom: 0,
                      child: GetBuilder<CartController>(builder: (controller) {
                        List<CartModel> _cartList = controller.getItems;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _cartList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Row(
                              children: [
                                InkWell(
                                  highlightColor: Colors.grey.shade50,
                                  splashColor: Colors.grey.shade50,
                                  onTap: () {
                                    int popularIndex =
                                        Get.find<PopularProductController>()
                                            .PopularProductList
                                            .indexOf(_cartList[index].product);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(RouteHelper.getPopularFood(
                                          popularIndex));
                                    } else {
                                      int recommendedIndex = Get.find<
                                              RecommendedProductController>()
                                          .RecommendedProductList
                                          .indexOf(_cartList[index].product);
                                      if (recommendedIndex >= 0) {
                                        Get.toNamed(
                                            RouteHelper.getrecommendedFood(
                                                recommendedIndex));
                                      } else {
                                        Get.snackbar("History Item",
                                            "Item not available for review.",
                                            backgroundColor:
                                                Colors.redAccent.shade200);
                                      }
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height20),
                                    height: Dimensions.listViewImgSize / 1.4,
                                    width: Dimensions.listViewImgSize / 1.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      image: DecorationImage(
                                          image: NetworkImage(AppConstants
                                                  .BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              controller.getItems[index].img!),
                                          fit: BoxFit.cover),
                                    ),
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
                                    height:
                                        Dimensions.PageViewTextContainer / 1.2,
                                    decoration: BoxDecoration(
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
                                          text:
                                              _cartList[index].name.toString(),
                                          color: AppColors.mainBlackColor,
                                        ),
                                        SmallText(
                                          text: "Spicy",
                                          color: Colors.black26,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "\$ ${_cartList[index].price}",
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.height20 / 4,
                                                  vertical:
                                                      Dimensions.height10 / 2),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15),
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: (() {
                                                        controller.addItems(
                                                            _cartList[index]
                                                                .product!,
                                                            -1);
                                                        Get.find<
                                                                PopularProductController>()
                                                            .updateInCartItems(
                                                          _cartList[index]
                                                              .product!,
                                                        );
                                                      }),
                                                      child:
                                                          Icon(Icons.remove)),
                                                  SizedBox(
                                                    width: Dimensions.width15,
                                                  ),
                                                  BigText(
                                                    text: _cartList[index]
                                                        .quantity
                                                        .toString(),
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.width15,
                                                  ),
                                                  InkWell(
                                                      onTap: (() {
                                                        controller.addItems(
                                                            _cartList[index]
                                                                .product!,
                                                            1);
                                                        Get.find<
                                                                PopularProductController>()
                                                            .updateInCartItems(
                                                          _cartList[index]
                                                              .product!,
                                                        );
                                                      }),
                                                      child: const Icon(
                                                          Icons.add)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    )
                  : NoDataPage(text: "Please add something to cart !");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (_cartController) {
            return _cartController.Items.isNotEmpty
                ? Container(
                    height: Dimensions.bottomHeightBar,
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width45),
                    decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.height20,
                              vertical: Dimensions.height10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Dimensions.width15,
                              ),
                              BigText(
                                text: "\$ ${_cartController.totalAmount()}",
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: Dimensions.width15,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.height20,
                              vertical: Dimensions.height10),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                          ),
                          child: InkWell(
                            onTap: () {
                              print("checkout tap");
                              if (Get.find<AuthController>().userLoggedIn()) {
                                if (Get.find<LocationController>()
                                    .addressList
                                    .isEmpty) {
                                  Get.toNamed(RouteHelper.getAddAddressPage());
                                }
                                // _cartController.addTOHistory();
                                // Get.find<PopularProductController>().update();
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                              // popularProduct.addItem(product);
                            },
                            child: BigText(
                              text: "Check out",
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    height: double.minPositive,
                  );
          },
        ),
      ),
    );
  }
}
