import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel {
  final String messageId;
  final String role; // "user" or "ai"
  final String message;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.messageId,
    required this.role,
    required this.message,
    required this.timestamp,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      messageId: map['messageId']?.toString() ?? '',
      role: map['role']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      timestamp: map['timestamp'] is Timestamp 
          ? (map['timestamp'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['timestamp']?.toString() ?? '') ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'role': role,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      messageId: entity.messageId,
      role: entity.role,
      message: entity.message,
      timestamp: entity.timestamp,
    );
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      messageId: messageId,
      role: role,
      message: message,
      timestamp: timestamp,
    );
  }

  ChatMessageModel copyWith({
    String? messageId,
    String? role,
    String? message,
    DateTime? timestamp,
  }) {
    return ChatMessageModel(
      messageId: messageId ?? this.messageId,
      role: role ?? this.role,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
