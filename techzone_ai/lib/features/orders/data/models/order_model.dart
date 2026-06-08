import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/order_entity.dart';
import 'order_item_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String customerName;
  final String customerPhone;
  final List<OrderItemModel> items;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final String status;
  final String orderNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderModel({
    required this.orderId,
    required this.userId,
    required this.customerName,
    required this.customerPhone,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    this.orderNotes = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      customerName: map['customerName']?.toString() ?? '',
      customerPhone: map['customerPhone']?.toString() ?? '',
      items: (map['items'] as List?)?.map((item) {
        if (item is Map<String, dynamic>) return OrderItemModel.fromMap(item);
        if (item is Map) return OrderItemModel.fromMap(Map<String, dynamic>.from(item));
        return const OrderItemModel(productId: '', name: '', imageUrl: '', price: 0.0, quantity: 0);
      }).toList() ?? [],
      totalAmount: map['totalAmount'] is num ? (map['totalAmount'] as num).toDouble() : double.tryParse(map['totalAmount']?.toString() ?? '') ?? 0.0,
      shippingAddress: map['shippingAddress']?.toString() ?? '',
      paymentMethod: map['paymentMethod']?.toString() ?? '',
      status: map['status']?.toString() ?? '',
      orderNotes: map['orderNotes']?.toString() ?? '',
      createdAt: map['createdAt'] is Timestamp 
          ? (map['createdAt'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now()),
      updatedAt: map['updatedAt'] is Timestamp 
          ? (map['updatedAt'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['updatedAt']?.toString() ?? '') ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'status': status,
      'orderNotes': orderNotes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      orderId: entity.orderId,
      userId: entity.userId,
      customerName: entity.customerName,
      customerPhone: entity.customerPhone,
      items: entity.items.map((item) => OrderItemModel.fromEntity(item)).toList(),
      totalAmount: entity.totalAmount,
      shippingAddress: entity.shippingAddress,
      paymentMethod: entity.paymentMethod,
      status: entity.status,
      orderNotes: entity.orderNotes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      userId: userId,
      customerName: customerName,
      customerPhone: customerPhone,
      items: items.map((item) => item.toEntity()).toList(),
      totalAmount: totalAmount,
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
      status: status,
      orderNotes: orderNotes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  OrderModel copyWith({
    String? orderId,
    String? userId,
    String? customerName,
    String? customerPhone,
    List<OrderItemModel>? items,
    double? totalAmount,
    String? shippingAddress,
    String? paymentMethod,
    String? status,
    String? orderNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      orderNotes: orderNotes ?? this.orderNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
