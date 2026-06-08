import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
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

  const ProductEntity({
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

  ProductEntity copyWith({
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
    return ProductEntity(
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

  @override
  List<Object?> get props => [
        productId,
        name,
        brand,
        categoryId,
        categoryName,
        description,
        price,
        stock,
        imageUrls,
        rating,
        reviewCount,
        warranty,
        specifications,
        isActive,
        createdAt,
        updatedAt,
      ];
}
