import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/order_provider.dart';
import 'order_detail_screen.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: orderState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
          ),
        ),
        data: (orders) {
          if (orders.isEmpty) {
            return const Center(
              child: Text('You have no orders yet.'),
            );
          }

          // Sort orders by created date descending
          final sortedOrders = List.of(orders)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            itemCount: sortedOrders.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spaceMd),
            itemBuilder: (context, index) {
              final order = sortedOrders[index];
              final itemCount = order.items.fold<int>(0, (sum, item) => sum + item.quantity);

              // Basic date formatting
              final date = '${order.createdAt.year}-${order.createdAt.month.toString().padLeft(2, '0')}-${order.createdAt.day.toString().padLeft(2, '0')}';

              return InkWell(
                onTap: () async {
                  if (_isNavigating) return;
                  setState(() => _isNavigating = true);
                  try {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderDetailScreen(order: order),
                      ),
                    );
                  } finally {
                    if (mounted) setState(() => _isNavigating = false);
                  }
                },
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Order #${order.orderId}',
                              style: AppTextStyles.titleMd,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.spaceSm,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                            ),
                            child: Text(
                              order.status.toUpperCase(),
                              style: AppTextStyles.labelSm.copyWith(
                                color: _getStatusColor(order.status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: AppDimensions.spaceLg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date:',
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          Text(
                            date,
                            style: AppTextStyles.bodyMd,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items:',
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          Text(
                            '$itemCount',
                            style: AppTextStyles.bodyMd,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceSm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          Text(
                            '\$${order.totalAmount.toStringAsFixed(2)}',
                            style: AppTextStyles.titleMd.copyWith(color: AppColors.primary),
                          ),
                        ],
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return AppColors.onSurfaceVariant;
    }
  }
}
