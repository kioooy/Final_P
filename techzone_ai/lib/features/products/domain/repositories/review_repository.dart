import '../entities/review_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class ReviewRepository {
  /// Fetches all reviews for a specific product.
  /// Throws an [Exception] if the operation fails.
  Future<List<ReviewEntity>> getReviews(String productId);

  /// Adds a new review for a product.
  /// Throws an [Exception] if the operation fails.
  Future<ReviewEntity> addReview(String productId, ReviewEntity review);

  /// Deletes a review.
  /// Throws an [Exception] if the operation fails.
  Future<void> deleteReview(String productId, String reviewId);
}
