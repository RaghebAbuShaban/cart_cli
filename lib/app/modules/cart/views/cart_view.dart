import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cart_cli/app/data/cart_item.dart';
import 'package:cart_cli/app/modules/cart/controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), centerTitle: true),

      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.all(16),

          itemCount: controller.cartItems.length,

          itemBuilder: (context, index) {
            CartItem item = controller.cartItems[index];

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
                      child: Text(item.product.name),
                    ),

                    SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Price: ${item.product.price.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            controller.incrementQuantity(item);
                          },
                        ),

                        Text(item.quantity.toString()),

                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            controller.decrementQuantity(item);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),

      bottomNavigationBar: Obx(() {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),

            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total: ${controller.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                ElevatedButton(
                  onPressed: controller.cartItems.isEmpty
                      ? null
                      : () {
                          controller.checkout();
                        },
                  child: Text('Check Out'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
