import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../../../core/di/providers.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

class CartNotifier extends AsyncNotifier<List<CartItemEntity>> {
  @override
  Future<List<CartItemEntity>> build() async {
    // Automatically re-fetch cart when auth state changes
    final user = ref.watch(authProvider).value;
    if (user == null) return [];
    return ref.read(cartRepositoryProvider).getCartItems(user.uid);
  }

  Future<void> getCartItems() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');
    
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(cartRepositoryProvider).getCartItems(user.uid);
    });
  }

  Future<void> addToCart(CartItemEntity item) async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(cartRepositoryProvider).addToCart(user.uid, item);
      return ref.read(cartRepositoryProvider).getCartItems(user.uid);
    });
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(cartRepositoryProvider).updateQuantity(user.uid, productId, quantity);
      return ref.read(cartRepositoryProvider).getCartItems(user.uid);
    });
  }

  Future<void> removeFromCart(String productId) async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(cartRepositoryProvider).removeFromCart(user.uid, productId);
      return ref.read(cartRepositoryProvider).getCartItems(user.uid);
    });
  }

  Future<void> clearCart() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(cartRepositoryProvider).clearCart(user.uid);
      return [];
    });
  }
}

final cartProvider = AsyncNotifierProvider<CartNotifier, List<CartItemEntity>>(CartNotifier.new);
