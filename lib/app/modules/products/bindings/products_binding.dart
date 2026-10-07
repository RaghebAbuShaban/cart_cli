import 'package:get/get.dart';
import 'package:cart_cli/app/modules/cart/controllers/cart_controller.dart';
import 'package:cart_cli/app/modules/products/controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.put<CartController>(CartController(), permanent: true);
  }
}