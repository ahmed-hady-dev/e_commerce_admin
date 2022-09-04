import 'package:e_commerce_admin/controllers/order_stats_controller.dart';
import 'package:e_commerce_admin/screens/orders_screen.dart';
import 'package:e_commerce_admin/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

import '../models/order_state_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final orderStatsController = Get.put(OrderStatsController());
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
          FutureBuilder(
            future: orderStatsController.stats.value,
            builder: (context, AsyncSnapshot<List<OrderStats>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 250,
                  padding: const EdgeInsets.all(10.0),
                  child: CustomBarChart(orderStats: OrderStats.data),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString(), style: const TextStyle());
              }
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            },
          ),
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
          ),
          Container(
            width: double.infinity,
            height: 150.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {
                Get.to(() => OrdersScreen());
              },
              child: const Card(
                child: Center(child: Text('Go to Orders')),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({Key? key, required this.orderStats}) : super(key: key);
  final List<OrderStats> orderStats;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (series, _) => DateFormat.d().format(series.dateTime),
        measureFn: (series, _) => series.orders,
        colorFn: (series, _) => series.barColor!,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
