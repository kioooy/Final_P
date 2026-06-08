import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/order_entity.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final date = '${order.createdAt.year}-${order.createdAt.month.toString().padLeft(2, '0')}-${order.createdAt.day.toString().padLeft(2, '0')}';
    final time = '${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
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
                          style: AppTextStyles.titleLg,
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
                  _buildInfoRow('Created Date:', '$date at $time'),
                  const SizedBox(height: AppDimensions.spaceSm),
                  _buildInfoRow('Payment Method:', order.paymentMethod),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Shipping Information Section
            Text('Shipping Information', style: AppTextStyles.titleLg),
            const SizedBox(height: AppDimensions.spaceMd),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Name:', order.customerName),
                  const SizedBox(height: AppDimensions.spaceSm),
                  _buildInfoRow('Phone:', order.customerPhone),
                  const SizedBox(height: AppDimensions.spaceSm),
                  Text(
                    'Address:',
                    style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppDimensions.spaceXs),
                  Text(
                    order.shippingAddress,
                    style: AppTextStyles.bodyMd,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Items Section
            Text('Order Items', style: AppTextStyles.titleLg),
            const SizedBox(height: AppDimensions.spaceMd),
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Column(
                children: order.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppDimensions.spaceSm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                          ),
                          child: item.imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                                  child: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image_outlined, size: 24, color: AppColors.onSurfaceVariant),
                                  ),
                                )
                              : const Icon(Icons.image_outlined, size: 24, color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(width: AppDimensions.spaceMd),
                        Expanded(
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
                                '${item.quantity}x \$${item.price.toStringAsFixed(2)}',
                                style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: AppTextStyles.titleMd,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLg),

            // Summary Section
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: AppTextStyles.titleLg.copyWith(color: AppColors.onPrimaryContainer),
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: AppTextStyles.titleLg.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceXl),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMd,
          ),
        ),
      ],
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
