import '../../domain/entities/cart_item_entity.dart';

class CartItemModel {
  final String productId;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final int quantity;

  const CartItemModel({
    required this.productId,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      brand: map['brand']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      price: map['price'] is num ? (map['price'] as num).toDouble() : double.tryParse(map['price']?.toString() ?? '') ?? 0.0,
      quantity: map['quantity'] is num ? (map['quantity'] as num).toInt() : int.tryParse(map['quantity']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      name: entity.name,
      brand: entity.brand,
      imageUrl: entity.imageUrl,
      price: entity.price,
      quantity: entity.quantity,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      productId: productId,
      name: name,
      brand: brand,
      imageUrl: imageUrl,
      price: price,
      quantity: quantity,
    );
  }

  CartItemModel copyWith({
    String? productId,
    String? name,
    String? brand,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
