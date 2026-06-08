import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/providers.dart';

class AdminState {
  final int totalProducts;
  final int totalOrders;
  final int totalUsers;
  final bool isLoading;
  final String? errorMessage;

  AdminState({
    this.totalProducts = 0,
    this.totalOrders = 0,
    this.totalUsers = 0,
    this.isLoading = true,
    this.errorMessage,
  });

  AdminState copyWith({
    int? totalProducts,
    int? totalOrders,
    int? totalUsers,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AdminState(
      totalProducts: totalProducts ?? this.totalProducts,
      totalOrders: totalOrders ?? this.totalOrders,
      totalUsers: totalUsers ?? this.totalUsers,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AdminNotifier extends Notifier<AdminState> {
  @override
  AdminState build() {
    Future.microtask(_init);
    return AdminState();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final products = await ref.read(productRepositoryProvider).getProducts();
      final orders = await ref.read(orderRepositoryProvider).getAllOrders();
      final users = await ref.read(userRepositoryProvider).getAllUsers();

      state = state.copyWith(
          totalProducts: products.length,
          totalOrders: orders.length,
          totalUsers: users.length,
          isLoading: false,
        );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await _init();
  }
}

final adminProvider = NotifierProvider<AdminNotifier, AdminState>(AdminNotifier.new);
