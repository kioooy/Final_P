import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../orders/presentation/pages/order_history_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen for logout event to navigate back to LoginScreen
    ref.listen(authProvider, (previous, next) {
      if (previous?.value != null && next.value == null && !next.isLoading && !next.hasError) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              if (_isNavigating) return;
              setState(() => _isNavigating = true);
              try {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              } finally {
                if (mounted) setState(() => _isNavigating = false);
              }
            },
          ),
        ],
      ),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
          ),
        ),
        data: (user) {
          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You are not logged in.',
                    style: AppTextStyles.bodyLg,
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  FilledButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text('Log In'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppDimensions.spaceLg),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primaryContainer,
                  backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                      ? NetworkImage(user.profileImage!)
                      : null,
                  child: user.profileImage == null || user.profileImage!.isEmpty
                      ? Text(
                          user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : '?',
                          style: AppTextStyles.displaySm.copyWith(color: AppColors.onPrimaryContainer),
                        )
                      : null,
                ),
                const SizedBox(height: AppDimensions.spaceMd),
                Text(
                  user.fullName,
                  style: AppTextStyles.headlineSm,
                ),
                const SizedBox(height: AppDimensions.spaceXs),
                Text(
                  user.role.toUpperCase(),
                  style: AppTextStyles.labelSm.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: AppDimensions.spaceXl),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      _buildProfileItem(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: user.email,
                      ),
                      const Divider(height: 1),
                      _buildProfileItem(
                        icon: Icons.phone_outlined,
                        title: 'Phone Number',
                        value: user.phone.isNotEmpty ? user.phone : 'Not provided',
                      ),
                      const Divider(height: 1),
                      _buildProfileItem(
                        icon: Icons.location_on_outlined,
                        title: 'Address',
                        value: user.address.isNotEmpty ? user.address : 'Not provided',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceLg),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long_outlined, color: AppColors.primary),
                    title: Text('Order History', style: AppTextStyles.titleMd),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                    onTap: () async {
                      if (_isNavigating) return;
                      setState(() => _isNavigating = true);
                      try {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
                        );
                      } finally {
                        if (mounted) setState(() => _isNavigating = false);
                      }
                    },
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXl),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ref.read(authProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout, color: AppColors.error),
                    label: Text(
                      'Logout',
                      style: AppTextStyles.labelLg.copyWith(color: AppColors.error),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMd),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Row(
        children: [
          Icon(icon, color: AppColors.onSurfaceVariant),
          const SizedBox(width: AppDimensions.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.bodyMd,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
