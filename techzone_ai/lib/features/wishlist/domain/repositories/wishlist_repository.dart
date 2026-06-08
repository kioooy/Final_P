import '../entities/wishlist_item_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class WishlistRepository {
  /// Retrieves the wishlist for a given user.
  /// Throws an [Exception] if the operation fails.
  Future<List<WishlistItemEntity>> getWishlistItems(String userId);

  /// Adds an item to the user's wishlist.
  /// Throws an [Exception] if the operation fails.
  Future<WishlistItemEntity> addToWishlist(String userId, WishlistItemEntity item);

  /// Removes an item from the user's wishlist by product ID.
  /// Throws an [Exception] if the operation fails.
  Future<void> removeFromWishlist(String userId, String productId);

  /// Checks if a product is in the user's wishlist.
  /// Throws an [Exception] if the operation fails.
  Future<bool> isInWishlist(String userId, String productId);
}
