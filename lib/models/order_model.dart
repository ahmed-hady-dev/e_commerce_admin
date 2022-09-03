import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  @override
  List<Object?> get props => [
        id,
        customerId,
        productIds,
        deliveryFee,
        subtotal,
        total,
        isAccepted,
        isDelivered,
        createdAt,
      ];

  final int id;
  final int customerId;
  final List<int> productIds;
  final double deliveryFee;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.deliveryFee,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.createdAt,
  });

  Order copyWith({
    int? id,
    int? customerId,
    List<int>? productIds,
    double? deliveryFee,
    double? subtotal,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'createdAt': createdAt,
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snap) {
    return Order(
      id: snap['id'] as int,
      customerId: snap['customerId'] as int,
      productIds: snap['productIds'] as List<int>,
      deliveryFee: snap['deliveryFee'] as double,
      subtotal: snap['subtotal'] as double,
      total: snap['total'] as double,
      isAccepted: snap['isAccepted'] as bool,
      isDelivered: snap['isDelivered'] as bool,
      createdAt: DateTime.fromMicrosecondsSinceEpoch(snap['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());
  @override
  bool? get stringify => true;

  static List<Order> orders = [
    Order(
      id: 1,
      customerId: 2345,
      productIds: const [1, 2],
      deliveryFee: 10,
      subtotal: 20,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
    Order(
      id: 2,
      customerId: 23,
      productIds: const [1, 2, 3],
      deliveryFee: 10,
      subtotal: 30,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
  ];
}