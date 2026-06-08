import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationModel {
  final String notificationId;
  final String title;
  final String content;
  final String targetType;
  final String? targetUserId;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.notificationId,
    required this.title,
    required this.content,
    required this.targetType,
    this.targetUserId,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      notificationId: map['notificationId']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      targetType: map['targetType']?.toString() ?? '',
      targetUserId: map['targetUserId']?.toString(),
      isRead: map['isRead'] == true,
      createdAt: map['createdAt'] is Timestamp 
          ? (map['createdAt'] as Timestamp).toDate() 
          : (DateTime.tryParse(map['createdAt']?.toString() ?? '') ?? DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'title': title,
      'content': content,
      'targetType': targetType,
      'targetUserId': targetUserId,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      notificationId: entity.notificationId,
      title: entity.title,
      content: entity.content,
      targetType: entity.targetType,
      targetUserId: entity.targetUserId,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      notificationId: notificationId,
      title: title,
      content: content,
      targetType: targetType,
      targetUserId: targetUserId,
      isRead: isRead,
      createdAt: createdAt,
    );
  }

  NotificationModel copyWith({
    String? notificationId,
    String? title,
    String? content,
    String? targetType,
    String? targetUserId,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      title: title ?? this.title,
      content: content ?? this.content,
      targetType: targetType ?? this.targetType,
      targetUserId: targetUserId ?? this.targetUserId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
