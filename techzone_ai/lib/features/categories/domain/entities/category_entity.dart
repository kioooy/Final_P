import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String categoryId;
  final String categoryName;
  final String imageUrl;

  const CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
  });

  CategoryEntity copyWith({
    String? categoryId,
    String? categoryName,
    String? imageUrl,
  }) {
    return CategoryEntity(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [categoryId, categoryName, imageUrl];
}
