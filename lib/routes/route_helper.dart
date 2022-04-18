import 'package:food_delivery/pages/address/add_address_page.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String addAddressPage = '/add-address-page';

  static getInitial() => "$initial";
  static getSplashScreen() => '$splashScreen';
  static getPopularFood(int index) => "$popularFood?pageId=$index";
  static getrecommendedFood(int index) => "$recommendedFood?pageId=$index";
  static getCartPage() => "$cartPage";
  static getSignInPage() => "$signIn";
  static getSignUpPage() => "$signUp";
  static getAddAddressPage() => "$addAddressPage";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return PopularFoodDetails(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommendedFoodDetails(
          pageId: int.parse(pageId!),
        );
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: signIn,
      page: () {
        return SignInPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signUp,
      page: () {
        return SignUpPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addAddressPage,
      page: () {
        return AddAddressPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
