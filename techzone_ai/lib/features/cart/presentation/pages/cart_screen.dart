import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/cart_provider.dart';
import '../../../orders/presentation/pages/checkout_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool _isMutating = false;
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: cartState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final total = items.fold<double>(
            0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMd),
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.spaceSm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: item.imageUrl.isNotEmpty
                                  ? Image.network(
                                      item.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                                    )
                                  : const Icon(Icons.image_outlined, size: 40, color: AppColors.onSurfaceVariant),
                            ),
                            const SizedBox(width: AppDimensions.spaceMd),
                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: AppTextStyles.titleMd,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: AppDimensions.spaceXs),
                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',
                                    style: AppTextStyles.bodyLg.copyWith(color: AppColors.primary),
                                  ),
                                  const SizedBox(height: AppDimensions.spaceSm),
                                  // Quantity controls and remove
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline),
                                            onPressed: item.quantity > 1 && !_isMutating
                                                ? () async {
                                                    setState(() => _isMutating = true);
                                                    try {
                                                      await ref.read(cartProvider.notifier).updateQuantity(
                                                            item.productId,
                                                            item.quantity - 1,
                                                          );
                                                    } finally {
                                                      if (mounted) setState(() => _isMutating = false);
                                                    }
                                                  }
                                                : null,
                                          ),
                                          Text(
                                            '${item.quantity}',
                                            style: AppTextStyles.titleMd,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline),
                                            onPressed: _isMutating ? null : () async {
                                              setState(() => _isMutating = true);
                                              try {
                                                await ref.read(cartProvider.notifier).updateQuantity(
                                                      item.productId,
                                                      item.quantity + 1,
                                                    );
                                              } finally {
                                                if (mounted) setState(() => _isMutating = false);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
                                        onPressed: _isMutating ? null : () async {
                                          setState(() => _isMutating = true);
                                          try {
                                            await ref.read(cartProvider.notifier).removeFromCart(item.productId);
                                          } finally {
                                            if (mounted) setState(() => _isMutating = false);
                                          }
                                        },
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
                ),
              ),
              // Footer
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceLg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: AppTextStyles.titleLg,
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: AppTextStyles.headlineMd.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceLg),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () async {
                            if (_isNavigating) return;
                            setState(() => _isNavigating = true);
                            try {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                              );
                            } finally {
                              if (mounted) setState(() => _isNavigating = false);
                            }
                          },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
