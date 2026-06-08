import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  const OrderItemEntity({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  OrderItemEntity copyWith({
    String? productId,
    String? name,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return OrderItemEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, name, imageUrl, price, quantity];
}
