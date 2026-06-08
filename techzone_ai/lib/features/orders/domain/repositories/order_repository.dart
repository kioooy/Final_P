import '../entities/order_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class OrderRepository {
  /// Creates a new order.
  /// Throws an [Exception] if creation fails.
  Future<OrderEntity> createOrder(OrderEntity order);

  /// Retrieves all orders for a specific user.
  /// Throws an [Exception] if the operation fails.
  Future<List<OrderEntity>> getUserOrders(String userId);

  /// Retrieves all orders (typically for admin use).
  /// Throws an [Exception] if the operation fails.
  Future<List<OrderEntity>> getAllOrders();

  /// Updates the status of a specific order.
  /// Throws an [Exception] if the update fails.
  Future<void> updateOrderStatus(String orderId, String status);
}
