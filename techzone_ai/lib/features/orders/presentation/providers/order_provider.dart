import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../../../core/di/providers.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

class OrderNotifier extends AsyncNotifier<List<OrderEntity>> {
  @override
  Future<List<OrderEntity>> build() async {
    // Initial fetch depends on whether the user is an admin or standard user
    // For now, let's load standard user orders by default
    final user = ref.watch(authProvider).value;
    if (user == null) return [];
    return ref.read(orderRepositoryProvider).getUserOrders(user.uid);
  }

  Future<void> createOrder(OrderEntity order) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(orderRepositoryProvider).createOrder(order);
      // Reload user's orders after creation
      final user = ref.read(authProvider).value;
      if (user == null) return [];
      return ref.read(orderRepositoryProvider).getUserOrders(user.uid);
    });
  }

  Future<void> getUserOrders() async {
    final user = ref.read(authProvider).value;
    if (user == null) throw Exception('User not logged in');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(orderRepositoryProvider).getUserOrders(user.uid);
    });
  }

  Future<void> getAllOrders() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(orderRepositoryProvider).getAllOrders();
    });
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(orderRepositoryProvider).updateOrderStatus(orderId, status);
      // After updating status, decide whether to load all orders or user orders.
      // Usually, updating status is an admin action, so we reload all orders.
      return ref.read(orderRepositoryProvider).getAllOrders();
    });
  }
}

final orderProvider = AsyncNotifierProvider<OrderNotifier, List<OrderEntity>>(OrderNotifier.new);
