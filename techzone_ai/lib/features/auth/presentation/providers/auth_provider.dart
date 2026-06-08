import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/di/providers.dart';

class AuthNotifier extends AsyncNotifier<UserEntity?> {
  @override
  Future<UserEntity?> build() async {
    return ref.watch(authRepositoryProvider).getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).login(email, password);
    });
  }

  Future<void> register(
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).register(fullName, email, phone, password);
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).logout();
      return null;
    });
  }

  Future<void> resetPassword(String email) async {
    // Reset password doesn't change auth state, just a network call
    await ref.read(authRepositoryProvider).resetPassword(email);
  }

  Future<void> getCurrentUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).getCurrentUser();
    });
  }

  Future<void> updateProfile(UserEntity user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatedUser = await ref.read(userRepositoryProvider).updateProfile(user);
      return updatedUser;
    });
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, UserEntity?>(AuthNotifier.new);
