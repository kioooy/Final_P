import 'package:equatable/equatable.dart';

class WishlistItemEntity extends Equatable {
  final String wishlistItemId;
  final String userId;
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final DateTime addedAt;

  const WishlistItemEntity({
    required this.wishlistItemId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.addedAt,
  });

  WishlistItemEntity copyWith({
    String? wishlistItemId,
    String? userId,
    String? productId,
    String? name,
    String? imageUrl,
    double? price,
    DateTime? addedAt,
  }) {
    return WishlistItemEntity(
      wishlistItemId: wishlistItemId ?? this.wishlistItemId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  List<Object?> get props => [
        wishlistItemId,
        userId,
        productId,
        name,
        imageUrl,
        price,
        addedAt,
      ];
}
