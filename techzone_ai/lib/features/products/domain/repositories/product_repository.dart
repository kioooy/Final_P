import '../entities/product_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class ProductRepository {
  /// Retrieves a list of all products.
  /// Throws an [Exception] if the operation fails.
  Future<List<ProductEntity>> getProducts();

  /// Retrieves a specific product by its ID.
  /// Throws an [Exception] if the product is not found or fetch fails.
  Future<ProductEntity> getProductById(String productId);

  /// Searches for products based on a query string.
  /// Throws an [Exception] if the operation fails.
  Future<List<ProductEntity>> searchProducts(String query);

  /// Creates a new product.
  /// Throws an [Exception] if the operation fails.
  Future<ProductEntity> createProduct(ProductEntity product);

  /// Updates an existing product.
  /// Throws an [Exception] if the operation fails.
  Future<ProductEntity> updateProduct(ProductEntity product);

  /// Deletes a product by its ID.
  /// Throws an [Exception] if the operation fails.
  Future<void> deleteProduct(String productId);

  /// Retrieves a list of products by category ID.
  /// Throws an [Exception] if the operation fails.
  Future<List<ProductEntity>> getProductsByCategory(String categoryId);

  /// Retrieves a list of featured products.
  /// Throws an [Exception] if the operation fails.
  Future<List<ProductEntity>> getFeaturedProducts();
}
