import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/helper/models/products_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_widet.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetails extends StatefulWidget {
  final int pageId;
  const PopularFoodDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  State<PopularFoodDetails> createState() => _PopularFoodDetailsState();
}

class _PopularFoodDetailsState extends State<PopularFoodDetails> {
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<PopularProductController>().PopularProductList[widget.pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: Dimensions.popularFoodImgSize,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: Dimensions.popularFoodImgSize - 20,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width35,
                            vertical: Dimensions.height15),
                        height: Dimensions.PageViewTextContainer,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20),
                          ),
                        ),
                        child: AppColumn(
                          text: product.name!,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: Dimensions.width45,
                  right: Dimensions.width45,
                  top: Dimensions.height15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppIcon(
                          iconData: Icons.arrow_back_ios,
                          ontap: () {
                            Get.close(0);
                            // Get.toNamed(RouteHelper.getInitial());
                          }),
                      GetBuilder<PopularProductController>(
                        builder: (controller) {
                          return InkWell(
                            onTap: () {
                              // if (controller.totalItems > 0)
                              Get.toNamed(RouteHelper.cartPage);
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
                                                fontSize: 11.0,
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
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.screenHeight / 8.44,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width35,
              ),
              child: BigText(
                text: "Introduce",
                color: AppColors.mainBlackColor,
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width35,
                ),
                child: SingleChildScrollView(
                  child: ExpandableTextWidget(text: product.description!),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
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
                        horizontal: Dimensions.height20,
                        vertical: Dimensions.height10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: (() {
                              popularProduct.getQuantity(false);
                            }),
                            child: Icon(Icons.remove)),
                        SizedBox(
                          width: Dimensions.width15,
                        ),
                        BigText(
                          text: popularProduct.inCartItems.toString(),
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: Dimensions.width15,
                        ),
                        InkWell(
                            onTap: (() {
                              popularProduct.getQuantity(true);
                            }),
                            child: Icon(Icons.add)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height20,
                        vertical: Dimensions.height10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    child: InkWell(
                      onTap: () {
                        popularProduct.addItem(product);
                      },
                      child: BigText(
                        text: "\$ ${product.price!} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
