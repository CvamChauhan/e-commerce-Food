class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://mvs.bslmeiyu.com";
  // php -q -S 127.0.0.1:80 -t public
  // static const String BASE_URL = "http://10.0.2.2:8000";
  static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URL = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads/";

  static const String REGISTRATION_URL = "/api/v1/auth/register";
  static const String LOGIN_URL = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";

  static const String TOKEN = "token";
  static const String NUMBER = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "Cart-List";
  static const String CART_HISTORY_LIST = "Cart-History-List";
}
