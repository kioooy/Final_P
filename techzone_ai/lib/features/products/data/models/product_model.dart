import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String productId;
  final String name;
  final String brand;
  final String categoryId;
  final String categoryName;
  final String description;
  final double price;
  final int stock;
  final List<String> imageUrls;
  final double rating;
  final int reviewCount;
  final String warranty;
  final Map<String, String> specifications;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductModel({
    required this.productId,
    required this.name,
    required this.brand,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrls,
    required this.rating,
    required this.reviewCount,
    required this.warranty,
    required this.specifications,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      brand: map['brand']?.toString() ?? '',
      categoryId: map['categoryId']?.toString() ?? '',
      categoryName: map['categoryName']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: map['price'] is num ? (map['price'] as num).toDouble() : double.tryParse(map['price']?.toString() ?? '') ?? 0.0,
      stock: map['stock'] is num ? (map['stock'] as num).toInt() : int.tryParse(map['stock']?.toString() ?? '') ?? 0,
      imageUrls: (map['imageUrls'] as List?)?.map((e) => e.toString()).toList() ?? [],
      rating: map['rating'] is num ? (map['rating'] as num).toDouble() : double.tryParse(map['rating']?.toString() ?? '') ?? 0.0,
      reviewCount: map['reviewCount'] is num ? (map['reviewCount'] as num).toInt() : int.tryParse(map['reviewCount']?.toString() ?? '') ?? 0,
      warranty: map['warranty']?.toString() ?? '',
      specifications: (map['specifications'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())) ?? {},
      isActive: map['isActive'] == true,
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
      'productId': productId,
      'name': name,
      'brand': brand,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'description': description,
      'price': price,
      'stock': stock,
      'imageUrls': imageUrls,
      'rating': rating,
      'reviewCount': reviewCount,
      'warranty': warranty,
      'specifications': specifications,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      productId: entity.productId,
      name: entity.name,
      brand: entity.brand,
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      description: entity.description,
      price: entity.price,
      stock: entity.stock,
      imageUrls: entity.imageUrls,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      warranty: entity.warranty,
      specifications: entity.specifications,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      name: name,
      brand: brand,
      categoryId: categoryId,
      categoryName: categoryName,
      description: description,
      price: price,
      stock: stock,
      imageUrls: imageUrls,
      rating: rating,
      reviewCount: reviewCount,
      warranty: warranty,
      specifications: specifications,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  ProductModel copyWith({
    String? productId,
    String? name,
    String? brand,
    String? categoryId,
    String? categoryName,
    String? description,
    double? price,
    int? stock,
    List<String>? imageUrls,
    double? rating,
    int? reviewCount,
    String? warranty,
    Map<String, String>? specifications,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      imageUrls: imageUrls ?? this.imageUrls,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      warranty: warranty ?? this.warranty,
      specifications: specifications ?? this.specifications,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
