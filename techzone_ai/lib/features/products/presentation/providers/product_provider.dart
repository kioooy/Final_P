import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product_entity.dart';
import '../../../../core/di/providers.dart';

class ProductNotifier extends AsyncNotifier<List<ProductEntity>> {
  @override
  Future<List<ProductEntity>> build() async {
    return getProducts();
  }

  Future<List<ProductEntity>> getProducts() async {
    return ref.read(productRepositoryProvider).getProducts();
  }

  Future<ProductEntity> getProductById(String productId) async {
    // This doesn't modify the global list state, just fetches a specific product
    return ref.read(productRepositoryProvider).getProductById(productId);
  }

  String _lastSearchQuery = '';

  Future<void> searchProducts(String query) async {
    _lastSearchQuery = query;
    state = const AsyncValue.loading();
    
    final result = await AsyncValue.guard(() async {
      if (query.isEmpty) {
        return ref.read(productRepositoryProvider).getProducts();
      }
      return ref.read(productRepositoryProvider).searchProducts(query);
    });

    if (_lastSearchQuery == query) {
      state = result;
    }
  }

  Future<void> loadProductsByCategory(String? categoryId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (categoryId == null) {
        return ref.read(productRepositoryProvider).getProducts();
      }
      return ref.read(productRepositoryProvider).getProductsByCategory(categoryId);
    });
  }
}

final productProvider = AsyncNotifierProvider<ProductNotifier, List<ProductEntity>>(ProductNotifier.new);

final featuredProductsProvider = FutureProvider<List<ProductEntity>>((ref) {
  return ref.read(productRepositoryProvider).getFeaturedProducts();
});
