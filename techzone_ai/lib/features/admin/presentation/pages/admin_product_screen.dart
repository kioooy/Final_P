import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/admin_product_provider.dart';
import 'admin_product_form_screen.dart';

class AdminProductScreen extends ConsumerWidget {
  const AdminProductScreen({super.key});

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String productId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                await ref.read(adminProductProvider.notifier).deleteProduct(productId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product deleted successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
                  );
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminProductProvider);
    final products = state.filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.spaceMd,
              0,
              AppDimensions.spaceMd,
              AppDimensions.spaceMd,
            ),
            child: SearchBar(
              hintText: 'Search products...',
              leading: const Icon(Icons.search),
              onChanged: (val) => ref.read(adminProductProvider.notifier).setSearchQuery(val),
              elevation: WidgetStateProperty.all(1),
            ),
          ),
        ),
      ),
      body: state.isLoading && state.products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null && state.products.isEmpty
              ? Center(
                  child: Text('Error: ${state.errorMessage}', style: AppTextStyles.bodyLg.copyWith(color: AppColors.error)),
                )
              : products.isEmpty
                  ? Center(
                      child: Text(
                        'No products found',
                        style: AppTextStyles.titleMd.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => ref.read(adminProductProvider.notifier).loadProducts(),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(AppDimensions.spaceMd),
                        itemCount: products.length,
                        separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spaceSm),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(AppDimensions.spaceSm),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                                child: product.imageUrls.isNotEmpty
                                    ? Image.network(
                                        product.imageUrls.first,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          width: 60,
                                          height: 60,
                                          color: AppColors.surfaceVariant,
                                          child: const Icon(Icons.broken_image),
                                        ),
                                      )
                                    : Container(
                                        width: 60,
                                        height: 60,
                                        color: AppColors.surfaceVariant,
                                        child: const Icon(Icons.image),
                                      ),
                              ),
                              title: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('\$${product.price.toStringAsFixed(2)} • Stock: ${product.stock}'),
                                  Text(product.categoryName, style: TextStyle(color: AppColors.onSurfaceVariant)),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: AppColors.primary),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AdminProductFormScreen(productToEdit: product),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: AppColors.error),
                                    onPressed: () => _showDeleteConfirmation(context, ref, product.productId),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminProductFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
