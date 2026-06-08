import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/wishlist_item_entity.dart';

class WishlistItemModel {
  final String wishlistItemId;
  final String userId;
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final DateTime addedAt;

  const WishlistItemModel({
    required this.wishlistItemId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.addedAt,
  });

  factory WishlistItemModel.fromMap(Map<String, dynamic> map) {
    return WishlistItemModel(
      wishlistItemId: map['wishlistItemId']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      productId: map['productId']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
      price: map['price'] is num ? (map['price'] as num).toDouble() : double.tryParse(map['price']?.toString() ?? '') ?? 0.0,
      addedAt: map['addedAt'] is Timestamp 
          ? (map['addedAt'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['addedAt']?.toString() ?? '') ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wishlistItemId': wishlistItemId,
      'userId': userId,
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'addedAt': Timestamp.fromDate(addedAt),
    };
  }

  factory WishlistItemModel.fromEntity(WishlistItemEntity entity) {
    return WishlistItemModel(
      wishlistItemId: entity.wishlistItemId,
      userId: entity.userId,
      productId: entity.productId,
      name: entity.name,
      imageUrl: entity.imageUrl,
      price: entity.price,
      addedAt: entity.addedAt,
    );
  }

  WishlistItemEntity toEntity() {
    return WishlistItemEntity(
      wishlistItemId: wishlistItemId,
      userId: userId,
      productId: productId,
      name: name,
      imageUrl: imageUrl,
      price: price,
      addedAt: addedAt,
    );
  }

  WishlistItemModel copyWith({
    String? wishlistItemId,
    String? userId,
    String? productId,
    String? name,
    String? imageUrl,
    double? price,
    DateTime? addedAt,
  }) {
    return WishlistItemModel(
      wishlistItemId: wishlistItemId ?? this.wishlistItemId,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
