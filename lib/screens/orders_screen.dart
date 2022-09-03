import 'package:e_commerce_admin/controllers/order_controller.dart';
import 'package:e_commerce_admin/models/order_model.dart';
import 'package:e_commerce_admin/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: orderController.orders.isEmpty
          ? Center(child: Text('there are no orders', style: const TextStyle()))
          : Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: orderController.pendingOrders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(
                      order: orderController.pendingOrders[index],
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({Key? key, required this.order}) : super(key: key);
  final Order order;
  final OrderController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    var products = Product.products.where((product) => order.productIds.contains(product.id)).toList();
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Order Id : ${order.id}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(DateFormat('dd-MM-yyyy').format(order.createdAt),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(products[index].name,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 285,
                              child: Text(
                                products[index].description,
                                style: const TextStyle(fontSize: 12.0),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: [
                      const Text('Delivery Fee ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 10.0),
                      Text(order.deliveryFee.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Total',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 10.0),
                      Text(order.total.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  order.isAccepted
                      ? ElevatedButton(
                          onPressed: () {
                            orderController.updateOrder(order, 'isDelivered', !order.isDelivered);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            maximumSize: const Size(150, 40),
                          ),
                          child: const Text('Deliver',
                              style: TextStyle(
                                fontSize: 12.0,
                              )))
                      : ElevatedButton(
                          onPressed: () {
                            orderController.updateOrder(order, 'isAccepted', !order.isAccepted);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            maximumSize: const Size(150, 40),
                          ),
                          child: const Text('Accept',
                              style: TextStyle(
                                fontSize: 12.0,
                              ))),
                  ElevatedButton(
                      onPressed: () {
                        orderController.updateOrder(order, 'isCancelled', !order.isCancelled);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        maximumSize: const Size(150, 40),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(
                            fontSize: 12.0,
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
