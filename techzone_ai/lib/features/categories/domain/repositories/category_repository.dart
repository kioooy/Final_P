import '../entities/category_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class CategoryRepository {
  /// Fetches all categories from the data source.
  /// Throws an [Exception] if the fetch fails.
  Future<List<CategoryEntity>> getCategories();

  /// Creates a new category.
  /// Throws an [Exception] if creation fails.
  Future<CategoryEntity> createCategory(CategoryEntity category);

  /// Updates an existing category.
  /// Throws an [Exception] if the update fails.
  Future<CategoryEntity> updateCategory(CategoryEntity category);

  /// Deletes a category by its ID.
  /// Throws an [Exception] if the deletion fails.
  Future<void> deleteCategory(String categoryId);
}
