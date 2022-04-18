import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_message.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/helper/models/sign_up_body_model.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    List<String> imgName = ["g.png", "t.png", "f.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String mobile = mobileController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar("Name cannot be Empty !", title: "Name");
      } else if (email.isEmpty) {
        showCustomSnackbar("Email cannot be Empty !", title: "Email");
      }
      // else if (GetUtils.isEmail(email)) {
      //   showCustomSnackbar("Invalid Email !", title: "Email");
      // }
      else if (mobile.isEmpty) {
        showCustomSnackbar("Mobile cannot be Empty !", title: "Mobile");
      }
      //else if (GetUtils.isPhoneNumber(mobile)) {
      //   showCustomSnackbar("Invalid Mobile  !", title: "Mobile");
      // }
      else if (password.isEmpty) {
        showCustomSnackbar("Password cannot be Empty !", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackbar("Must be greater than 6.", title: "Password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, mobile: mobile, password: password);
        authController.registration(signUpBody).then((value) {
          if (value.isSuccess) {
            showCustomSnackbar("Registration Successfull",
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
                        height: Dimensions.height10,
                      ),
                      Image.asset(
                        "assets/image/logo part 1.png",
                        width: Dimensions.splashImg,
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      TextFieldWidget(
                        icon: Icons.person,
                        hintText: "Name",
                        controller: nameController,
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      TextFieldWidget(
                        icon: Icons.phone,
                        hintText: "Mobile",
                        controller: mobileController,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
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
                        height: Dimensions.height45,
                      ),
                      InkWell(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30 * 2),
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
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
                              _registration(_authController);
                            },
                            child: BigText(
                              text: "Sign-up",
                              color: Colors.white,
                              size: Dimensions.iconSize24,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: Dimensions.iconSize16,
                            ),
                            children: [
                              TextSpan(
                                  text: " Sign-in",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.iconSize16,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.close(1);
                                      Get.toNamed(RouteHelper.getSignInPage());
                                    })
                            ]),
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      SmallText(
                        text: "Sign up using one of the following methods.",
                        color: Colors.grey,
                        size: Dimensions.font16,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Wrap(
                        spacing: Dimensions.width30 * 2,
                        children: List.generate(
                            imgName.length,
                            (index) => CircleAvatar(
                                  backgroundImage: AssetImage(
                                      "assets/image/${imgName[index]}"),
                                )),
                      )
                    ],
                  ),
                )
              : CustomLoader();
        }),
      ),
    ));
  }
}
