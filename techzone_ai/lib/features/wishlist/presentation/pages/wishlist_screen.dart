import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/wishlist_provider.dart';
import '../../../products/presentation/providers/product_provider.dart';
import '../../../products/presentation/pages/product_detail_screen.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({super.key});

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final wishlistState = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: wishlistState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Your wishlist is empty.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimensions.spaceMd,
              mainAxisSpacing: AppDimensions.spaceMd,
              childAspectRatio: 0.65,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: _isNavigating ? null : () async {
                  setState(() => _isNavigating = true);
                  try {
                    // Fetch full product details before navigating
                    final product = await ref.read(productProvider.notifier).getProductById(item.productId);
                    if (context.mounted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to load product details.')),
                      );
                    }
                  } finally {
                    if (mounted) {
                      setState(() => _isNavigating = false);
                    }
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
                      // Product Image & Remove Button
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              color: AppColors.surfaceContainerHigh,
                              child: item.imageUrl.isNotEmpty
                                  ? Image.network(
                                      item.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                                    )
                                  : const Icon(Icons.image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                            ),
                            Positioned(
                              top: AppDimensions.spaceXs,
                              right: AppDimensions.spaceXs,
                              child: IconButton(
                                icon: const Icon(Icons.favorite, color: AppColors.error),
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColors.surface.withValues(alpha: 0.8),
                                ),
                                onPressed: () {
                                  ref.read(wishlistProvider.notifier).removeFromWishlist(item.productId);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppDimensions.spaceSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: AppTextStyles.labelLg,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppDimensions.spaceXs),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: AppTextStyles.titleMd.copyWith(color: AppColors.primary),
                            ),
                            const SizedBox(height: AppDimensions.spaceXs),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: AppDimensions.spaceXs),
                                Text(
                                  '4.5', // Placeholder rating as it's not in WishlistItemEntity
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
