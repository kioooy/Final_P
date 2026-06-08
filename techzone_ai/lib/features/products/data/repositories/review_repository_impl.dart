import '../../domain/repositories/review_repository.dart';
import '../../domain/entities/review_entity.dart';
import '../models/review_model.dart';
import '../datasources/review_remote_data_source.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource _remoteDataSource;

  ReviewRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ReviewEntity>> getReviews(String productId) async {
    final models = await _remoteDataSource.getReviews(productId);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<ReviewEntity> addReview(String productId, ReviewEntity review) async {
    final model = ReviewModel.fromEntity(review);
    final createdModel = await _remoteDataSource.addReview(productId, model);
    return createdModel.toEntity();
  }

  @override
  Future<void> deleteReview(String productId, String reviewId) async {
    await _remoteDataSource.deleteReview(productId, reviewId);
  }
}
