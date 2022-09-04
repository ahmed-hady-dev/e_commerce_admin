import 'package:e_commerce_admin/models/order_state_model.dart';
import 'package:e_commerce_admin/services/datebase_service.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DatabaseService database = DatabaseService();
  var stats = Future.value(<OrderStats>[]).obs;
  @override
  void onInit() {
    stats.value = database.getOrderStas();
    super.onInit();
  }
}
