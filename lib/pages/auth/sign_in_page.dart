import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_message.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/helper/models/sign_up_body_model.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  Function(bool iaLoggedIn)? update;
  SignInPage({Key? key, this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackbar("Email cannot be Empty !", title: "Email");
      }
      // else if (GetUtils.isEmail(email)) {
      //   showCustomSnackbar("Invalid Email !", title: "Email");
      // }

      else if (password.isEmpty) {
        showCustomSnackbar("Password cannot be Empty !", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackbar("Must be greater than 6.", title: "Password");
      } else {
        authController.login(email, password).then((value) {
          if (value.isSuccess) {
            showCustomSnackbar("Login Successfull",
                title: "Success", color: AppColors.mainColor);
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(value.message, title: "Failed");
          }
        });
      }
    }

    return SafeArea(
        child: Material(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Image.asset(
                        "assets/image/logo part 1.png",
                        width: Dimensions.splashImg,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width45),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Hello",
                              color: Colors.black,
                              size: Dimensions.font20 * 4,
                            ),
                            BigText(
                              text: "Sign into your account",
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      TextFieldWidget(
                        icon: Icons.email,
                        hintText: "Email",
                        controller: emailController,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      TextFieldWidget(
                        icon: Icons.password,
                        hintText: "Password",
                        controller: passwordController,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      Container(
                          margin: EdgeInsets.only(right: Dimensions.width45),
                          width: double.infinity,
                          child: Text(
                            "Sign into your account",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: Dimensions.font20),
                          )),
                      SizedBox(
                        height: Dimensions.height30 * 2,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.height10 * 4,
                            vertical: Dimensions.height15),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30 * 2),
                        ),
                        child: InkWell(
                          onTap: () {
                            _login(_authController);
                          },
                          child: BigText(
                            text: "Sign-In",
                            color: Colors.white,
                            size: Dimensions.iconSize24,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: Dimensions.iconSize16,
                            ),
                            children: [
                              TextSpan(
                                text: "Create",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.iconSize16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.close(1);
                                    Get.toNamed(RouteHelper.getSignUpPage());
                                  },
                              )
                            ]),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                    ],
                  ),
                )
              : CustomLoader();
        }),
      ),
    ));
  }
}
