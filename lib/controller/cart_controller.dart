import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/helper/models/cart_model.dart';
import 'package:food_delivery/helper/models/products_model.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:get/get.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  List<CartModel> storageItems = []; //only for storage & shared preferences

  Map<int, CartModel> get Items => _items;
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  void addItems(ProductModel product, int quantity) {
    int totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = quantity + value.quantity!;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: (quantity + value.quantity!),
          isExit: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if ((totalQuantity) <= 0) {
        _items.remove(product.id!);
      }
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExit: true,
          time: DateTime.now().toString(),
          product: product,
        ),
      );
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    } else {
      return false;
    }
  }

  getQuantity(ProductModel product) {
    int quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int totalItems() {
    int totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  int totalAmount() {
    int totalAmount = 0;
    _items.forEach((key, value) {
      totalAmount += (value.price! * value.quantity!);
    });
    return totalAmount;
  }

  List<CartModel> getCartData() {
    setCart = (cartRepo.getCartList());
    return storageItems;
  }

  set setCart(List<CartModel> Items) {
    storageItems = Items;
    // print("length" + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addTOHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> get getCartHistoryList => cartRepo.getCartHistoryList();

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistoryList();
    update();
  }
}
