import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/cart_item_model.dart';

class CartRemoteDataSource {
  final FirebaseFirestore _firestore;

  CartRemoteDataSource(this._firestore);

  Future<List<CartItemModel>> getCartItems(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.cartItems)
          .get();
      return snapshot.docs.map((doc) => CartItemModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get cart items: $e');
    }
  }

  Future<void> addToCart(String userId, CartItemModel item) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.cartItems)
          .doc(item.productId)
          .set(item.toMap());
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> updateQuantity(String userId, String productId, int quantity) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.cartItems)
          .doc(productId)
          .update({'quantity': quantity});
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  Future<void> removeFromCart(String userId, String productId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.cartItems)
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  Future<void> clearCart(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.cartItems)
          .get();
      
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
