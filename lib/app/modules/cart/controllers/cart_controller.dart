import 'package:get/get.dart';
import 'package:cart_cli/app/data/cart_item.dart';
import 'package:cart_cli/app/data/database_helper.dart';
import 'package:cart_cli/app/data/product.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  int get cartCount {
    int count = 0;
    for (CartItem item in cartItems) {
      count = count + item.quantity;
    }
    return count;
  }

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() async {
    List<CartItem> items = await DatabaseHelper.getCartItems();
    cartItems.assignAll(items);
  }

  void addToCart(Product product) async {
    CartItem? found;

    for (CartItem item in cartItems) {
      if (item.product.name == product.name) {
        found = item;
      }
    }

    if (found != null) {
      found.quantity++;
      cartItems.refresh();
      await DatabaseHelper.updateItem(found);
    } else {
      CartItem newItem = CartItem(product: product, quantity: 1);
      cartItems.add(newItem);
      await DatabaseHelper.insertItem(newItem);
    }
  }

  void incrementQuantity(CartItem item) async {
    item.quantity++;
    cartItems.refresh();
    await DatabaseHelper.updateItem(item);
  }

  void decrementQuantity(CartItem item) async {
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
      await DatabaseHelper.updateItem(item);
    } else {
      cartItems.remove(item);
      await DatabaseHelper.deleteItem(item);
    }
  }

  double get totalPrice {
    double total = 0;
    for (CartItem item in cartItems) {
      total = total + item.product.price * item.quantity;
    }
    return total;
  }

  void checkout() async {
    double total = totalPrice;

    cartItems.clear();
    await DatabaseHelper.clearCart();

    Get.back();
  }
}
