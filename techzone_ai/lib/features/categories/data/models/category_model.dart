import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String imageUrl;

  const CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId']?.toString() ?? '',
      categoryName: map['categoryName']?.toString() ?? '',
      imageUrl: map['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      imageUrl: entity.imageUrl,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
      imageUrl: imageUrl,
    );
  }

  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    String? imageUrl,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
