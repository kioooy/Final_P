import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/order_provider.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill fields if user data is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authProvider).value;
      if (user != null) {
        if (user.address.isNotEmpty) _addressController.text = user.address;
        if (user.phone.isNotEmpty) _phoneController.text = user.phone;
      }
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final cartState = ref.read(cartProvider);
    final cartItems = cartState.value;
    if (cartItems == null || cartItems.isEmpty) return;

    final user = ref.read(authProvider).value;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to place an order.')),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);

    try {
      final orderItems = cartItems.map((item) {
        return OrderItemEntity(
          productId: item.productId,
          name: item.name,
          imageUrl: item.imageUrl,
          price: item.price,
          quantity: item.quantity,
        );
      }).toList();

      final subtotal = orderItems.fold<double>(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );
      const shippingFee = 15.0; // Fixed shipping fee for MVP
      final totalAmount = subtotal + shippingFee;

      final order = OrderEntity(
        orderId: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.uid,
        customerName: user.fullName,
        customerPhone: _phoneController.text.trim(),
        items: orderItems,
        totalAmount: totalAmount,
        shippingAddress: _addressController.text.trim(),
        paymentMethod: 'Credit Card', // Default for MVP
        status: 'Pending',
        orderNotes: _notesController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(orderProvider.notifier).createOrder(order);
      await ref.read(cartProvider.notifier).clearCart();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully!')),
        );
        Navigator.pop(context); // Go back to Cart or Home
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to place order: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isPlacingOrder = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: cartState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final subtotal = items.fold<double>(
            0,
            (sum, item) => sum + (item.price * item.quantity),
          );
          const shippingFee = 15.0;
          final totalAmount = subtotal + shippingFee;

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary', style: AppTextStyles.titleLg),
                  const SizedBox(height: AppDimensions.spaceMd),
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Column(
                      children: items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppDimensions.spaceSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${item.quantity}x ${item.name}',
                                  style: AppTextStyles.bodyMd,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),
                  Text('Shipping Information', style: AppTextStyles.titleLg),
                  const SizedBox(height: AppDimensions.spaceMd),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Shipping Address',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your shipping address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Order Notes (Optional)',
                      prefixIcon: Icon(Icons.note_alt_outlined),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppDimensions.spaceXl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: AppTextStyles.bodyLg),
                      Text('\$${subtotal.toStringAsFixed(2)}', style: AppTextStyles.bodyLg),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping Fee', style: AppTextStyles.bodyLg),
                      Text('\$${shippingFee.toStringAsFixed(2)}', style: AppTextStyles.bodyLg),
                    ],
                  ),
                  const Divider(height: AppDimensions.spaceLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.titleLg),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: AppTextStyles.titleLg.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceXl),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _isPlacingOrder || items.isEmpty ? null : _placeOrder,
                      child: _isPlacingOrder
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.onPrimary,
                              ),
                            )
                          : const Text('Place Order'),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceXl),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
