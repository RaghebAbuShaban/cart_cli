import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cart_cli/app/data/product.dart';
import 'package:cart_cli/app/modules/cart/controllers/cart_controller.dart';
import 'package:cart_cli/app/modules/products/controllers/products_controller.dart';
import 'package:cart_cli/app/routes/app_pages.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        centerTitle: true,

        actions: [
          Obx(() {
            int cartCount = cartController.cartCount;

            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_bag_outlined),
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                ),

                if (cartCount > 0)
                  Positioned(
                    right: 5,
                    top: 5,

                    child: Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),

                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),

                      child: Text(
                        cartCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(16),

        itemCount: controller.products.length,

        itemBuilder: (context, index) {
          Product product = controller.products[index];

          return Card(
            margin: EdgeInsets.only(bottom: 16),

            child: Padding(
              padding: EdgeInsets.all(10),

              child: Row(
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    alignment: Alignment.center,
                    color: Colors.grey,
                    child: Text(product.name),
                  ),

                  SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: TextStyle(fontSize: 18)),
                        SizedBox(height: 4),
                        Text('Price: ${product.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      cartController.addToCart(product);
                    },
                    child: Text('Add To Cart'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
