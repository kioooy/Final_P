import 'package:equatable/equatable.dart';
import 'order_item_entity.dart';

class OrderEntity extends Equatable {
  final String orderId;
  final String userId;
  final String customerName;
  final String customerPhone;
  final List<OrderItemEntity> items;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final String status;
  final String orderNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderEntity({
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

  OrderEntity copyWith({
    String? orderId,
    String? userId,
    String? customerName,
    String? customerPhone,
    List<OrderItemEntity>? items,
    double? totalAmount,
    String? shippingAddress,
    String? paymentMethod,
    String? status,
    String? orderNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderEntity(
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

  @override
  List<Object?> get props => [
        orderId,
        userId,
        customerName,
        customerPhone,
        items,
        totalAmount,
        shippingAddress,
        paymentMethod,
        status,
        orderNotes,
        createdAt,
        updatedAt,
      ];
}
