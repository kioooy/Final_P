import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/category_provider.dart';
import '../../../products/presentation/pages/product_list_screen.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: categoryState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
          ),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(child: Text('No categories found.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimensions.spaceMd,
              mainAxisSpacing: AppDimensions.spaceMd,
              childAspectRatio: 1.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () async {
                  if (_isNavigating) return;
                  setState(() => _isNavigating = true);
                  try {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductListScreen(categoryId: category.categoryId),
                      ),
                    );
                  } finally {
                    if (mounted) setState(() => _isNavigating = false);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: AppColors.surfaceContainerHigh,
                          child: category.imageUrl.isNotEmpty
                              ? Image.network(
                                  category.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                                )
                              : const Icon(Icons.category_outlined, size: 40, color: AppColors.onSurfaceVariant),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppDimensions.spaceSm),
                        color: AppColors.surface,
                        child: Text(
                          category.categoryName,
                          style: AppTextStyles.titleMd,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
