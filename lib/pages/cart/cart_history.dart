import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/helper/models/cart_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList.reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    int listCounter = 0;

    Widget timeWidget() {
      String output = DateTime.now().toString();
      if (listCounter < getCartHistoryList.length) {
        DateTime input = DateTime.parse(getCartHistoryList[listCounter].time!);
        output = DateFormat("MM/dd/yyyy hh:mm:a").format(input);
      }

      return BigText(
        text: output,
        color: AppColors.mainBlackColor,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.mainColor,
              height: Dimensions.bottomHeightBar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(
                    text: "Cart History",
                    color: Colors.white,
                  ),
                  AppIcon(iconData: Icons.shopping_cart_sharp)
                ],
              ),
            ),
            GetBuilder<CartController>(
              builder: (_cartController) {
                return _cartController.getCartHistoryList.isNotEmpty
                    ? Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(
                              left: Dimensions.width30,
                              right: Dimensions.width30,
                              top: Dimensions.height15),
                          children: <Widget>[
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        timeWidget(),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        Row(
                                          children: [
                                            Wrap(
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                    .width10 /
                                                                2),
                                                        height: Dimensions
                                                                .listViewImgSize /
                                                            1.6,
                                                        width: Dimensions
                                                                .listViewImgSize /
                                                            1.6,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                getCartHistoryList[
                                                                        listCounter -
                                                                            1]
                                                                    .img!),
                                                          ),
                                                        ),
                                                      )
                                                    : Container();
                                              }),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.height45 * 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SmallText(
                                            text: "Total",
                                            color: AppColors.titleColor,
                                          ),
                                          BigText(
                                            text: itemsPerOrder[i].toString() +
                                                " Items",
                                            color: AppColors.titleColor,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              var orderTime =
                                                  cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder =
                                                  {};
                                              for (int j = 0;
                                                  j < getCartHistoryList.length;
                                                  j++) {
                                                if (orderTime[i] ==
                                                    getCartHistoryList[j]
                                                        .time) {
                                                  moreOrder.putIfAbsent(
                                                      getCartHistoryList[j].id!,
                                                      () => CartModel.fromJson(
                                                          jsonDecode(jsonEncode(
                                                              getCartHistoryList[
                                                                  j]))));
                                                }
                                              }
                                              Get.find<CartController>()
                                                  .setItems = moreOrder;
                                              Get.find<CartController>()
                                                  .addToCartList();
                                              Get.find<CartController>()
                                                  .update();
                                              Get.find<
                                                      PopularProductController>()
                                                  .update();
                                              Get.find<
                                                      PopularProductController>()
                                                  .totalItems;
                                              Get.toNamed(
                                                  RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width20,
                                                  vertical:
                                                      Dimensions.height10 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.height10 /
                                                              2),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.mainColor)),
                                              child: SmallText(
                                                text: "One More",
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child: NoDataPage(
                            text: "You didn't buy anything so far !",
                            imgPath: "assets/image/empty_box.png",
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
