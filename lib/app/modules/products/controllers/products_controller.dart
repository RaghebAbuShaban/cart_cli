import 'package:get/get.dart';
import 'package:cart_cli/app/data/product.dart';

class ProductsController extends GetxController {
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 25.5),
    Product(name: 'Product 3', price: 15.0),
    Product(name: 'Product 4', price: 40.0),
  ];
}
