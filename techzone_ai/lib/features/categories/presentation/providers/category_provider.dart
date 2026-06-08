import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category_entity.dart';
import '../../../../core/di/providers.dart';

class CategoryNotifier extends AsyncNotifier<List<CategoryEntity>> {
  @override
  Future<List<CategoryEntity>> build() async {
    return ref.read(categoryRepositoryProvider).getCategories();
  }

  Future<void> refreshCategories() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(categoryRepositoryProvider).getCategories();
    });
  }
}

final categoryProvider = AsyncNotifierProvider<CategoryNotifier, List<CategoryEntity>>(CategoryNotifier.new);
