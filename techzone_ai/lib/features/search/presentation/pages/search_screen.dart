import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../products/presentation/providers/product_provider.dart';
import '../../../products/presentation/pages/product_detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounceTimer;
  bool _isInitialState = true;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    // Request focus immediately on screen load for better UX
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
      // Optional: Clear previous global productProvider search state if any
      // but only if we want to show all products or empty initially.
      // We will show empty initial state locally.
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      setState(() {
        _isInitialState = true;
      });
      // Optionally reset the provider to show all products, but standard 
      // search screens often just show history or empty state when blank.
      return;
    }

    setState(() {
      _isInitialState = false;
    });

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      ref.read(productProvider.notifier).searchProducts(trimmedQuery);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isInitialState = true;
    });
    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: AppColors.onSurfaceVariant),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.onSurfaceVariant),
                    onPressed: _clearSearch,
                  )
                : null,
          ),
          textInputAction: TextInputAction.search,
          onChanged: _onSearchChanged,
          onSubmitted: (query) {
            _onSearchChanged(query);
            _searchFocusNode.unfocus();
          },
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: _buildBody(productsState),
    );
  }

  Widget _buildBody(AsyncValue productsState) {
    if (_isInitialState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 64,
              color: AppColors.outlineVariant,
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            Text(
              'Search for products...',
              style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return productsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          'Error: $error',
          style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
        ),
      ),
      data: (products) {
        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.sentiment_dissatisfied,
                  size: 64,
                  color: AppColors.outlineVariant,
                ),
                const SizedBox(height: AppDimensions.spaceMd),
                Text(
                  'No results found for "${_searchController.text.trim()}"',
                  style: AppTextStyles.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          );
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
    );
  }
}
