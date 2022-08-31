import 'package:e_commerce_admin/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My eCommerce'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {
                Get.to(() => ProductsScreen());
              },
              child: const Card(
                child: Center(child: Text('Go to products')),
              ),
            ),
          )
        ],
      )),
    );
  }
}
