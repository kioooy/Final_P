import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/product_provider.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  final String? categoryId;

  const ProductListScreen({super.key, this.categoryId});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).loadProductsByCategory(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: productsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text(error.toString(), style: AppTextStyles.bodyLg.copyWith(color: AppColors.error)),
        ),
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimensions.spaceMd,
              mainAxisSpacing: AppDimensions.spaceMd,
              childAspectRatio: 0.65,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () async {
                  if (_isNavigating) return;
                  setState(() => _isNavigating = true);
                  try {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image placeholder
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: AppColors.surfaceContainerHigh,
                          child: product.imageUrls.isNotEmpty 
                            ? Image.network(
                                product.imageUrls.first,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                              )
                            : const Icon(Icons.image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimensions.spaceSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: AppTextStyles.labelLg,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppDimensions.spaceXs),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: AppTextStyles.titleMd.copyWith(color: AppColors.primary),
                            ),
                            const SizedBox(height: AppDimensions.spaceXs),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: AppDimensions.spaceXs),
                                Text(
                                  '${product.rating} (${product.reviewCount})',
                                  style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ],
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
