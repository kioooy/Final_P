import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final String productId;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final int quantity;

  const CartItemEntity({
    required this.productId,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  CartItemEntity copyWith({
    String? productId,
    String? name,
    String? brand,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        brand,
        imageUrl,
        price,
        quantity,
      ];
}
