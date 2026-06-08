import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/notification_model.dart';

class NotificationRemoteDataSource {
  final FirebaseFirestore _firestore;

  NotificationRemoteDataSource(this._firestore);

  Stream<List<NotificationModel>> getNotifications(String userId) {
    try {
      return _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.notifications)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => NotificationModel.fromMap(doc.data()))
              .toList());
    } catch (e) {
      throw Exception('Failed to stream notifications: $e');
    }
  }

  Future<NotificationModel> createNotification(String userId, NotificationModel notification) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.notifications)
          .doc(notification.notificationId)
          .set(notification.toMap());
      return notification;
    } catch (e) {
      throw Exception('Failed to create notification: $e');
    }
  }

  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.notifications)
          .doc(notificationId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.notifications)
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }
}
