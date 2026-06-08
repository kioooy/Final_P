import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/product_entity.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../wishlist/domain/entities/wishlist_item_entity.dart';
import '../../../wishlist/presentation/providers/wishlist_provider.dart';
import '../../../orders/presentation/pages/checkout_screen.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  bool _isNavigating = false;
  bool _isWishlistMutating = false;

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final isCartLoading = cartState.isLoading;
    final wishlistState = ref.watch(wishlistProvider);
    
    final bool isInWishlist = wishlistState.value?.any((item) => item.productId == widget.product.productId) ?? false;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
            icon: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist ? Colors.red : null,
            ),
            onPressed: _isWishlistMutating ? null : () async {
              setState(() => _isWishlistMutating = true);
              try {
                if (isInWishlist) {
                  await ref.read(wishlistProvider.notifier).removeFromWishlist(widget.product.productId);
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Removed from Wishlist')),
                  );
                } else {
                  final user = ref.read(authProvider).value;
                  if (user == null) {
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('Please log in to add to wishlist')),
                    );
                    if (mounted) setState(() => _isWishlistMutating = false);
                    return;
                  }
                  final item = WishlistItemEntity(
                    wishlistItemId: DateTime.now().millisecondsSinceEpoch.toString(),
                    userId: user.uid,
                    productId: widget.product.productId,
                    name: widget.product.name,
                    imageUrl: widget.product.imageUrls.isNotEmpty ? widget.product.imageUrls.first : '',
                    price: widget.product.price,
                    addedAt: DateTime.now(),
                  );
                  await ref.read(wishlistProvider.notifier).addToWishlist(item);
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text('Added to Wishlist')),
                  );
                }
              } catch (e) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text('Failed to update wishlist: $e')),
                );
              } finally {
                if (mounted) setState(() => _isWishlistMutating = false);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              ),
              clipBehavior: Clip.antiAlias,
              child: widget.product.imageUrls.isNotEmpty
                ? Image.network(
                    widget.product.imageUrls.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 80, color: AppColors.onSurfaceVariant),
                  )
                : const Icon(Icons.image_outlined, size: 80, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            
            // Name and Category
            Text(
              widget.product.name,
              style: AppTextStyles.headlineMd,
            ),
            const SizedBox(height: AppDimensions.spaceXs),
            Text(
              '${widget.product.brand} - ${widget.product.categoryName}',
              style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            
            // Price and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.headlineLg.copyWith(color: AppColors.primary),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: AppDimensions.spaceXs),
                    Text(
                      '${widget.product.rating} (${widget.product.reviewCount} reviews)',
                      style: AppTextStyles.titleMd,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            
            // Description
            Text(
              'Description',
              style: AppTextStyles.titleLg,
            ),
            const SizedBox(height: AppDimensions.spaceSm),
            Text(
              widget.product.description,
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            
            // Specifications
            if (widget.product.specifications.isNotEmpty) ...[
              Text(
                'Specifications',
                style: AppTextStyles.titleLg,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              ...widget.product.specifications.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppDimensions.spaceXs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          entry.key,
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          entry.value,
                          style: AppTextStyles.bodyMd,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: AppDimensions.spaceLg),
            ],

            // Warranty
            if (widget.product.warranty.isNotEmpty) ...[
              Text(
                'Warranty',
                style: AppTextStyles.titleLg,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Text(
                widget.product.warranty,
                style: AppTextStyles.bodyMd,
              ),
              const SizedBox(height: AppDimensions.spaceXxl),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isCartLoading ? null : () async {
                    final item = CartItemEntity(
                      productId: widget.product.productId,
                      name: widget.product.name,
                      brand: widget.product.brand,
                      imageUrl: widget.product.imageUrls.isNotEmpty ? widget.product.imageUrls.first : '',
                      price: widget.product.price,
                      quantity: 1,
                    );
                    try {
                      await ref.read(cartProvider.notifier).addToCart(item);
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(content: Text('Added to Cart successfully!')),
                      );
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Failed: $e')),
                      );
                    }
                  },
                  child: isCartLoading
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMd),
              Expanded(
                child: FilledButton(
                  onPressed: isCartLoading ? null : () async {
                    if (_isNavigating) return;
                    setState(() => _isNavigating = true);
                    final item = CartItemEntity(
                      productId: widget.product.productId,
                      name: widget.product.name,
                      brand: widget.product.brand,
                      imageUrl: widget.product.imageUrls.isNotEmpty ? widget.product.imageUrls.first : '',
                      price: widget.product.price,
                      quantity: 1,
                    );
                    try {
                      await ref.read(cartProvider.notifier).addToCart(item);
                      await navigator.push(
                        MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                      );
                    } catch (e) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text('Failed: $e')),
                      );
                    } finally {
                      if (mounted) setState(() => _isNavigating = false);
                    }
                  },
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
