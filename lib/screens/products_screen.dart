import 'package:e_commerce_admin/controllers/product_controller.dart';
import 'package:e_commerce_admin/screens/new_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../models/product_model.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: 100,
                  child: Card(
                    color: Colors.black,
                    margin: EdgeInsets.zero,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.to(() => NewProductScreen());
                            },
                            icon: const Icon(Icons.add_circle, color: Colors.white)),
                        Text('Add a new Product',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
                      ],
                    ),
                  )),
              Expanded(
                  child: ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  return Obx(() => SizedBox(
                        height: 210.0,
                        child: ProductCard(product: productController.products[index], index: index),
                      ));
                },
              ))
            ],
          )),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  ProductCard({Key? key, required this.product, required this.index}) : super(key: key);
  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              product.name,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              product.description,
              style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Price',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.price,
                              min: 0.0,
                              max: 25,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductPrice(index, product, value);
                              },
                            ),
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(1)}',
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 50,
                            child: Text(
                              'Qty.',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.quantity.toDouble(),
                              min: 0.0,
                              max: 100,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.black12,
                              onChanged: (value) {
                                productController.updateProductQuantity(index, product, value.toInt());
                              },
                            ),
                          ),
                          Text(
                            '${product.quantity.toInt()}',
                            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
