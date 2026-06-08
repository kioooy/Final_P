import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../models/chat_message_model.dart';

class ChatRemoteDataSource {
  final FirebaseFirestore _firestore;

  ChatRemoteDataSource(this._firestore);

  Stream<List<ChatMessageModel>> getMessages(String userId) {
    try {
      return _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.chatMessages)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatMessageModel.fromMap(doc.data()))
              .toList());
    } catch (e) {
      throw Exception('Failed to stream chat messages: $e');
    }
  }

  Future<void> saveMessage(String userId, ChatMessageModel message) async {
    try {
      await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.chatMessages)
          .doc(message.messageId)
          .set(message.toMap());
    } catch (e) {
      throw Exception('Failed to save chat message: $e');
    }
  }

  Future<void> clearHistory(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConstants.users)
          .doc(userId)
          .collection(FirebaseConstants.chatMessages)
          .get();
      
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear chat history: $e');
    }
  }
}
