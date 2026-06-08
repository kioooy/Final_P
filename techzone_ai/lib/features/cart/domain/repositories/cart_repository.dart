import '../entities/cart_item_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class CartRepository {
  /// Retrieves all cart items for a given user.
  /// Throws an [Exception] if the operation fails.
  Future<List<CartItemEntity>> getCartItems(String userId);

  /// Adds an item to the user's cart.
  /// Throws an [Exception] if the operation fails.
  Future<void> addToCart(String userId, CartItemEntity item);

  /// Updates the quantity of an existing item in the cart.
  /// Throws an [Exception] if the operation fails.
  Future<void> updateQuantity(String userId, String productId, int quantity);

  /// Removes a specific item from the user's cart.
  /// Throws an [Exception] if the operation fails.
  Future<void> removeFromCart(String userId, String productId);

  /// Clears all items from the user's cart.
  /// Throws an [Exception] if the operation fails.
  Future<void> clearCart(String userId);
}
