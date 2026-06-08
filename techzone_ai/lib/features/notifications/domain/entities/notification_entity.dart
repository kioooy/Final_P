import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String notificationId;
  final String title;
  final String content;
  final String targetType;
  final String? targetUserId;
  final bool isRead;
  final DateTime createdAt;

  const NotificationEntity({
    required this.notificationId,
    required this.title,
    required this.content,
    required this.targetType,
    this.targetUserId,
    required this.isRead,
    required this.createdAt,
  });

  NotificationEntity copyWith({
    String? notificationId,
    String? title,
    String? content,
    String? targetType,
    String? targetUserId,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      content: content ?? this.content,
      targetType: targetType ?? this.targetType,
      targetUserId: targetUserId ?? this.targetUserId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        notificationId,
        title,
        content,
        targetType,
        targetUserId,
        isRead,
        createdAt,
      ];
}
