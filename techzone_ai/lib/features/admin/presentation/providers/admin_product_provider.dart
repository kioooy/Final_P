import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/providers.dart';
import '../../../products/domain/entities/product_entity.dart';
import 'admin_provider.dart';

class AdminProductState {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  AdminProductState({
    this.products = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  AdminProductState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return AdminProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<ProductEntity> get filteredProducts {
    if (searchQuery.isEmpty) return products;
    final lowerQuery = searchQuery.toLowerCase();
    return products.where((p) => p.name.toLowerCase().contains(lowerQuery)).toList();
  }
}

class AdminProductNotifier extends Notifier<AdminProductState> {
  @override
  AdminProductState build() {
    Future.microtask(loadProducts);
    return AdminProductState(isLoading: true);
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final products = await ref.read(productRepositoryProvider).getProducts();
      state = state.copyWith(products: products, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> createProduct(ProductEntity product) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(productRepositoryProvider).createProduct(product);
      await loadProducts(); // Refresh list
      ref.read(adminProvider.notifier).refresh(); // Optionally refresh admin dashboard totals
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }
  }

  Future<void> updateProduct(ProductEntity product) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(productRepositoryProvider).updateProduct(product);
      await loadProducts();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(productRepositoryProvider).deleteProduct(productId);
      await loadProducts();
      ref.read(adminProvider.notifier).refresh(); // Optionally refresh admin dashboard totals
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }
  }
}

final adminProductProvider = NotifierProvider<AdminProductNotifier, AdminProductState>(AdminProductNotifier.new);
