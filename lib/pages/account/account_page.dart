import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/controller/location_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      // Get.find<LocationController>().getAddressList();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: Dimensions.bottomHeightBar,
          elevation: 0,
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Profile",
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: !_userLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/image/signintocontinue.png'),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      height: Dimensions.height20 * 5,
                      width: Dimensions.height20 * 10,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.height45 * 2)),
                      child: Center(
                        child: BigText(
                          text: "Sign-In",
                          color: Colors.white,
                          size: Dimensions.font26,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : GetBuilder<UserController>(
                builder: (userController) {
                  return !userController.isLoading
                      ? SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              CircleAvatar(
                                radius: Dimensions.height20 * 3,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: Dimensions.height20 * 3,
                                ),
                                backgroundColor: AppColors.mainColor,
                              ),
                              SizedBox(
                                height: Dimensions.height30,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          iconData: Icons.person,
                                          iconColor: Colors.white,
                                          backgroundColor: AppColors.mainColor,
                                          size: Dimensions.iconSize16 * 2,
                                          iconSize: Dimensions.iconSize16 * 1.5,
                                        ),
                                        bigText: BigText(
                                          text: userController.userModel!.name,
                                          color: AppColors.mainBlackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          iconData: Icons.phone,
                                          iconColor: Colors.white,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          size: Dimensions.iconSize16 * 2,
                                          iconSize: Dimensions.iconSize16 * 1.5,
                                        ),
                                        bigText: BigText(
                                          text: userController.userModel!.phone,
                                          color: AppColors.mainBlackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          iconData: Icons.mail,
                                          iconColor: Colors.white,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          size: Dimensions.iconSize16 * 2,
                                          iconSize: Dimensions.iconSize16 * 1.5,
                                        ),
                                        bigText: BigText(
                                          text: userController.userModel!.email,
                                          color: AppColors.mainBlackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      GetBuilder<LocationController>(
                                          builder: (locationController) {
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(RouteHelper
                                                .getAddAddressPage());
                                          },
                                          child: AccountWidget(
                                            appIcon: AppIcon(
                                              iconData: Icons.location_on,
                                              iconColor: Colors.white,
                                              backgroundColor:
                                                  AppColors.yellowColor,
                                              size: Dimensions.iconSize16 * 2,
                                              iconSize:
                                                  Dimensions.iconSize16 * 1.5,
                                            ),
                                            bigText: BigText(
                                              text: (_userLoggedIn &&
                                                      locationController
                                                          .addressList.isEmpty)
                                                  ? "Fill in your address"
                                                  : "Your address",
                                              color: AppColors.mainBlackColor,
                                            ),
                                          ),
                                        );
                                      }),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          iconData: Icons.message,
                                          iconColor: Colors.white,
                                          backgroundColor: Colors.redAccent,
                                          size: Dimensions.iconSize16 * 2,
                                          iconSize: Dimensions.iconSize16 * 1.5,
                                        ),
                                        bigText: BigText(
                                          text: "Message",
                                          color: AppColors.mainBlackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (Get.find<AuthController>()
                                              .userLoggedIn()) {
                                            Get.find<AuthController>()
                                                .clearSharedData();
                                            Get.find<CartController>().clear();
                                            Get.find<CartController>()
                                                .clearCartHistory();
                                            Get.find<LocationController>()
                                                .clearAddressList();
                                            Get.offAllNamed(
                                                RouteHelper.getSignInPage());
                                            // Get.toNamed(RouteHelper.getInitial());
                                          }
                                        },
                                        child: AccountWidget(
                                          appIcon: AppIcon(
                                            iconData: Icons.logout,
                                            iconColor: Colors.white,
                                            backgroundColor: Colors.redAccent,
                                            size: Dimensions.iconSize16 * 2,
                                            iconSize:
                                                Dimensions.iconSize16 * 1.5,
                                          ),
                                          bigText: BigText(
                                            text: "Logout",
                                            color: AppColors.mainBlackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : CustomLoader();
                },
              ),
      ),
    );
  }
}
