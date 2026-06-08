import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/wishlist_item_model.dart';

class WishlistRemoteDataSource {
  final FirebaseFirestore _firestore;

  WishlistRemoteDataSource(this._firestore);

  Future<List<WishlistItemModel>> getWishlistItems(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.wishlist)
          .orderBy('addedAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => WishlistItemModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get wishlist items: $e');
    }
  }

  Future<WishlistItemModel> addToWishlist(String userId, WishlistItemModel item) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.wishlist)
          .doc(item.productId)
          .set(item.toMap());
      return item;
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<void> removeFromWishlist(String userId, String productId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.wishlist)
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  Future<bool> isInWishlist(String userId, String productId) async {
    try {
      final doc = await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.wishlist)
          .doc(productId)
          .get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check wishlist: $e');
    }
  }
}
