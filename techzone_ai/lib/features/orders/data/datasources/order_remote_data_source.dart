import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/order_model.dart';

class OrderRemoteDataSource {
  final FirebaseFirestore _firestore;

  OrderRemoteDataSource(this._firestore);

  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      await _firestore
          .collection(FirebaseConstants.orders)
          .doc(order.orderId)
          .set(order.toMap());
      return order;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.orders)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get user orders: $e');
    }
  }

  Future<List<OrderModel>> getAllOrders() async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.orders)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => OrderModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get all orders: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestore
          .collection(FirebaseConstants.orders)
          .doc(orderId)
          .update({
            'status': status,
            'updatedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }
}
