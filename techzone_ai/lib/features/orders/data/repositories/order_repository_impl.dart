import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';
import '../datasources/order_remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<OrderEntity> createOrder(OrderEntity order) async {
    final model = OrderModel.fromEntity(order);
    final createdModel = await _remoteDataSource.createOrder(model);
    return createdModel.toEntity();
  }

  @override
  Future<List<OrderEntity>> getUserOrders(String userId) async {
    final models = await _remoteDataSource.getUserOrders(userId);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    final models = await _remoteDataSource.getAllOrders();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateOrderStatus(String orderId, String status) async {
    await _remoteDataSource.updateOrderStatus(orderId, status);
  }
}
