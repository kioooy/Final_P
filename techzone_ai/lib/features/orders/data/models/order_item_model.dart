import '../../domain/entities/order_item_entity.dart';

class OrderItemModel {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map['productId']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      price: map['price'] is num ? (map['price'] as num).toDouble() : double.tryParse(map['price']?.toString() ?? '') ?? 0.0,
      quantity: map['quantity'] is num ? (map['quantity'] as num).toInt() : int.tryParse(map['quantity']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      productId: entity.productId,
      name: entity.name,
      imageUrl: entity.imageUrl,
      price: entity.price,
      quantity: entity.quantity,
    );
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      productId: productId,
      name: name,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity,
    );
  }

  OrderItemModel copyWith({
    String? productId,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return OrderItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
