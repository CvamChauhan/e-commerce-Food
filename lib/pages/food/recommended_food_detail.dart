import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/controller/recommended_product_controller.dart';
import 'package:food_delivery/helper/models/products_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_widet.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetails({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<RecommendedProductController>().RecommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    iconData: Icons.clear,
                    ontap: () {
                      Get.close(0);
                      // Get.toNamed(RouteHelper.getInitial());
                    },
                  ),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return InkWell(
                        onTap: () async {
                          if (controller.totalItems > 0) {
                            await Get.toNamed(RouteHelper.cartPage);
                            // Get.find<PopularProductController>()
                            //     .updateInCartItems(
                            //   product,
                            // );
                          }
                        },
                        child: Stack(
                          children: <Widget>[
                            AppIcon(
                              iconData: Icons.shopping_cart_outlined,
                            ),
                            controller.totalItems > 0
                                ? Positioned(
                                    top: 2.0,
                                    right: 0,
                                    child: Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            controller.totalItems > 0
                                ? Positioned(
                                    top: 4.0,
                                    right: 3.0,
                                    child: Center(
                                      child: Text(
                                        controller.totalItems.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              pinned: true,
              toolbarHeight: Dimensions.height45 * 2,
              expandedHeight: Dimensions.pageView,
              backgroundColor: AppColors.yellowColor,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                fit: BoxFit.cover,
              )),
              bottom: PreferredSize(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                  child: Center(
                    child: BigText(
                      text: product.name!,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(0),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width35),
                  child: ExpandableTextWidget(text: product.description!)),
            )
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width45 * 3.5,
                    vertical: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      iconData: Icons.remove,
                      ontap: () {
                        controller.getQuantity(false);
                      },
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                    BigText(
                      text: " \$ ${product.price!}  X " +
                          " ${controller.inCartItems} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    AppIcon(
                      iconData: Icons.add,
                      ontap: () {
                        controller.getQuantity(true);
                      },
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width45),
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
                            horizontal: Dimensions.height15,
                            vertical: Dimensions.height10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    InkWell(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.height20,
                            vertical: Dimensions.height10),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                        ),
                        child: BigText(
                          text: "\$ ${product.price} Add to cart",
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
