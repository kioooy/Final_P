import '../../domain/repositories/wishlist_repository.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../models/wishlist_item_model.dart';
import '../datasources/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource _remoteDataSource;

  WishlistRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<WishlistItemEntity>> getWishlistItems(String userId) async {
    final models = await _remoteDataSource.getWishlistItems(userId);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<WishlistItemEntity> addToWishlist(String userId, WishlistItemEntity item) async {
    final model = WishlistItemModel.fromEntity(item);
    final addedModel = await _remoteDataSource.addToWishlist(userId, model);
    return addedModel.toEntity();
  }

  @override
  Future<void> removeFromWishlist(String userId, String productId) async {
    await _remoteDataSource.removeFromWishlist(userId, productId);
  }

  @override
  Future<bool> isInWishlist(String userId, String productId) async {
    return await _remoteDataSource.isInWishlist(userId, productId);
  }
}
