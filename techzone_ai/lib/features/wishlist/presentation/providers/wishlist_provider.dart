import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../../../core/di/providers.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

class WishlistNotifier extends AsyncNotifier<List<WishlistItemEntity>> {
  @override
  Future<List<WishlistItemEntity>> build() async {
    final user = ref.watch(authProvider).value;
    if (user == null) return [];
    return ref.read(wishlistRepositoryProvider).getWishlistItems(user.uid);
  }

  Future<void> getWishlistItems() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(wishlistRepositoryProvider).getWishlistItems(user.uid);
    });
  }

  Future<void> addToWishlist(WishlistItemEntity item) async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(wishlistRepositoryProvider).addToWishlist(user.uid, item);
      return ref.read(wishlistRepositoryProvider).getWishlistItems(user.uid);
    });
  }

  Future<void> removeFromWishlist(String productId) async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(wishlistRepositoryProvider).removeFromWishlist(user.uid, productId);
      return ref.read(wishlistRepositoryProvider).getWishlistItems(user.uid);
    });
  }

  Future<bool> isInWishlist(String productId) async {
    final user = ref.read(authProvider).value;
    if (user == null) return false;
    return ref.read(wishlistRepositoryProvider).isInWishlist(user.uid, productId);
  }
}

final wishlistProvider = AsyncNotifierProvider<WishlistNotifier, List<WishlistItemEntity>>(WishlistNotifier.new);
