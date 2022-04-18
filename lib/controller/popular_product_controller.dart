import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/helper/models/cart_model.dart';
import 'package:food_delivery/helper/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController implements GetxService {
  PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get PopularProductList => _popularProductList;

  late CartController _cart = CartController(cartRepo: Get.find());

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  int get totalItems => _cart.totalItems();

  void updateInCartItems(ProductModel product) {
    _inCartItems = _cart.getQuantity(product);
    update();
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void initProduct(ProductModel product, CartController cart) {
    _cart = cart;
    _quantity = 0;
    _inCartItems = 0;

    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void getQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
    print("quantity $quantity");
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item count", "You cannot add more items!",
          backgroundColor: AppColors.mainColor);
      return quantity - 1;
    } else if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You cannot reduce more items!",
          backgroundColor: AppColors.mainColor);
      return quantity + 1;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product) {
    if (_inCartItems > 0 || _quantity > 0) {
      _cart.addItems(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);
      print(_inCartItems.toString());
    } else {
      Get.snackbar("Item count", "You should add at least an item in the cart",
          backgroundColor: AppColors.mainColor);
    }
    update();
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
