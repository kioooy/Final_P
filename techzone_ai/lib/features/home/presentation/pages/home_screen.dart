import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../products/presentation/providers/product_provider.dart';
import '../../../products/presentation/pages/product_detail_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../widgets/main_bottom_navigation.dart';
import '../../../products/presentation/pages/product_list_screen.dart';
import '../../../wishlist/presentation/pages/wishlist_screen.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../categories/presentation/providers/category_provider.dart';
import '../../../categories/presentation/pages/category_screen.dart';
import '../../../notifications/presentation/pages/notification_screen.dart';
import '../../../search/presentation/pages/search_screen.dart';
import '../../../chat/presentation/pages/chat_screen.dart';
import '../../../maps/presentation/pages/map_screen.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../admin/presentation/pages/admin_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  bool _isNavigating = false;

  Widget _buildHomeTab() {
    final authState = ref.watch(authProvider);
    final user = authState.value;
    
    debugPrint('HOME ROLE: ${user?.role}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('TechZone AI'),
        centerTitle: false,
        actions: [
          if (user != null && user.role == 'admin')
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () async {
                if (_isNavigating) return;
                setState(() => _isNavigating = true);
                try {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminScreen()),
                  );
                } finally {
                  if (mounted) setState(() => _isNavigating = false);
                }
              },
            ),
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () async {
              if (_isNavigating) return;
              setState(() => _isNavigating = true);
              try {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapScreen()),
                );
              } finally {
                if (mounted) setState(() => _isNavigating = false);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () async {
              if (_isNavigating) return;
              setState(() => _isNavigating = true);
              try {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatScreen()),
                );
              } finally {
                if (mounted) setState(() => _isNavigating = false);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () async {
              if (_isNavigating) return;
              setState(() => _isNavigating = true);
              try {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              } finally {
                if (mounted) setState(() => _isNavigating = false);
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
            // Search Bar Placeholder -> Navigates to SearchScreen
            GestureDetector(
              onTap: () async {
                if (_isNavigating) return;
                setState(() => _isNavigating = true);
                try {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                } finally {
                  if (mounted) setState(() => _isNavigating = false);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceMd,
                  vertical: AppDimensions.spaceSm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: AppDimensions.spaceSm),
                    Text(
                      'Search products...',
                      style: AppTextStyles.bodyLg.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            
            // Promotional Banner Placeholder
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              ),
              child: Center(
                child: Text(
                  'Promotional Banner',
                  style: AppTextStyles.headlineMd.copyWith(
                    color: AppColors.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            
            // Categories Section
            Text(
              'Categories',
              style: AppTextStyles.titleLg,
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            SizedBox(
              height: 100,
              child: ref.watch(categoryProvider).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
                data: (categories) {
                  if (categories.isEmpty) return const Center(child: Text('No categories'));
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
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
                          width: 80,
                          margin: const EdgeInsets.only(right: AppDimensions.spaceMd),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryContainer,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              category.imageUrl.isNotEmpty
                                  ? Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(AppDimensions.spaceSm),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                                          child: Image.network(
                                            category.imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 24, color: AppColors.onSurfaceVariant),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Expanded(child: Icon(Icons.category_outlined, color: AppColors.onSecondaryContainer)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: AppDimensions.spaceSm),
                                child: Text(
                                  category.categoryName,
                                  style: AppTextStyles.labelSm.copyWith(
                                    color: AppColors.onSecondaryContainer,
                                  ),
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
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Featured Products Placeholder Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Products',
                  style: AppTextStyles.titleLg,
                ),
                TextButton(
                  onPressed: () async {
                    if (_isNavigating) return;
                    setState(() => _isNavigating = true);
                    try {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProductListScreen()),
                      );
                    } finally {
                      if (mounted) setState(() => _isNavigating = false);
                    }
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            ref.watch(featuredProductsProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
              data: (products) {
                if (products.isEmpty) return const Center(child: Text('No featured products'));
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _buildHomeTab(),
      const CategoryScreen(),
      const WishlistScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: MainBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
