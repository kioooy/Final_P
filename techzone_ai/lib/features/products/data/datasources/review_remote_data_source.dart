import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/review_model.dart';

class ReviewRemoteDataSource {
  final FirebaseFirestore _firestore;

  ReviewRemoteDataSource(this._firestore);

  Future<List<ReviewModel>> getReviews(String productId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.products)
          .doc(productId)
          .collection(FirebaseConstants.reviews)
          .orderBy('createdAt', descending: true)
          .get();
      return snapshot.docs.map((doc) => ReviewModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get reviews: $e');
    }
  }

  Future<ReviewModel> addReview(String productId, ReviewModel review) async {
    try {
      await _firestore
          .collection(FirebaseConstants.products)
          .doc(productId)
          .collection(FirebaseConstants.reviews)
          .doc(review.reviewId)
          .set(review.toMap());
      return review;
    } catch (e) {
      throw Exception('Failed to add review: $e');
    }
  }

  Future<void> deleteReview(String productId, String reviewId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.products)
          .doc(productId)
          .collection(FirebaseConstants.reviews)
          .doc(reviewId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete review: $e');
    }
  }
}
