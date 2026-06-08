import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String messageId;
  final String role; // "user" or "ai"
  final String message;
  final DateTime timestamp;

  const ChatMessageEntity({
    required this.messageId,
    required this.role,
    required this.message,
    required this.timestamp,
  });

  ChatMessageEntity copyWith({
    String? messageId,
    String? role,
    String? message,
    DateTime? timestamp,
  }) {
    return ChatMessageEntity(
      messageId: messageId ?? this.messageId,
      role: role ?? this.role,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [messageId, role, message, timestamp];
}
