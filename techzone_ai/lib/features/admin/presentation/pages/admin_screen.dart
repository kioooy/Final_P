import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/admin_provider.dart';
import 'admin_product_screen.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);
    
    debugPrint('ADMIN SCREEN ROLE: ${userState.value?.role}');

    return userState.when(
      data: (user) {
        if (user == null || user.role != 'admin') {
          return const _AccessDeniedScreen();
        }
        return const _AdminDashboard();
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _AccessDeniedScreen extends StatelessWidget {
  const _AccessDeniedScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Access Denied'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 64, color: AppColors.error),
            const SizedBox(height: AppDimensions.spaceMd),
            Text(
              'Access Denied',
              style: AppTextStyles.titleLg.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: AppDimensions.spaceSm),
            Text(
              'You do not have permission to view this page.',
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminDashboard extends ConsumerWidget {
  const _AdminDashboard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(adminProvider.notifier).refresh(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.spaceLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                        const SizedBox(height: AppDimensions.spaceMd),
                        Text(
                          'Failed to load dashboard data',
                          style: AppTextStyles.titleMd,
                        ),
                        const SizedBox(height: AppDimensions.spaceSm),
                        Text(
                          state.errorMessage!,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => ref.read(adminProvider.notifier).refresh(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overview',
                          style: AppTextStyles.titleLg,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                title: 'Products',
                                value: state.totalProducts.toString(),
                                icon: Icons.inventory_2_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.spaceSm),
                            Expanded(
                              child: _StatCard(
                                title: 'Orders',
                                value: state.totalOrders.toString(),
                                icon: Icons.shopping_bag_outlined,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.spaceSm),
                            Expanded(
                              child: _StatCard(
                                title: 'Users',
                                value: state.totalUsers.toString(),
                                icon: Icons.people_outline,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.spaceXl),
                        Text(
                          'Quick Actions',
                          style: AppTextStyles.titleLg,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        _ActionCard(
                          title: 'Manage Products',
                          subtitle: 'Add, edit, or remove products',
                          icon: Icons.inventory,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AdminProductScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        _ActionCard(
                          title: 'Manage Orders',
                          subtitle: 'View and update order statuses',
                          icon: Icons.local_shipping,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming in Phase 20B')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spaceMd),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: AppDimensions.spaceSm),
            Text(
              value,
              style: AppTextStyles.titleLg.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.spaceXs),
            Text(
              title,
              style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: Icon(icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: AppDimensions.spaceLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMd,
                    ),
                    const SizedBox(height: AppDimensions.spaceXs),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
