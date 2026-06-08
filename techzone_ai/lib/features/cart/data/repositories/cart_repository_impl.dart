import '../../domain/repositories/cart_repository.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../models/cart_item_model.dart';
import '../datasources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CartItemEntity>> getCartItems(String userId) async {
    final models = await _remoteDataSource.getCartItems(userId);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addToCart(String userId, CartItemEntity item) async {
    final model = CartItemModel.fromEntity(item);
    await _remoteDataSource.addToCart(userId, model);
  }

  @override
  Future<void> updateQuantity(String userId, String productId, int quantity) async {
    await _remoteDataSource.updateQuantity(userId, productId, quantity);
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    await _remoteDataSource.removeFromCart(userId, productId);
  }

  @override
  Future<void> clearCart(String userId) async {
    await _remoteDataSource.clearCart(userId);
  }
}
