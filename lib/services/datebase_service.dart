import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/models/order_model.dart';
import 'package:e_commerce_admin/models/order_state_model.dart';
import 'package:e_commerce_admin/models/product_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
    Product product,
    String field,
    dynamic newValue,
  ) {
    print(product.id);
    return _firebaseFirestore
        .collection('products')
        .where(
          'id',
          isEqualTo: product.id,
        )
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }

  Future<void> updateOrder(
    Order order,
    String field,
    dynamic newValue,
  ) {
    print(order.id);
    return _firebaseFirestore
        .collection('orders')
        .where(
          'id',
          isEqualTo: order.id,
        )
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.first.reference.update({field: newValue})
            });
  }

  Stream<List<Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapShot) {
      return snapShot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Order>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapShot) {
      return snapShot.docs.map((doc) => Order.fromSnapshot(doc)).toList();
    });
  }

  Future<List<OrderStats>> getOrderStas() {
    return _firebaseFirestore
        .collection('order_stats')
        .orderBy('dateTime')
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map(
              (entry) => OrderStats.fromSnapshot(entry.value, entry.key),
            )
            .toList());
  }
}
