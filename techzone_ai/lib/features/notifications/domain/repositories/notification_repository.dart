import '../entities/notification_entity.dart';

/// **Error Handling Strategy**: Exception Throwing
/// 
/// All methods return `Future<T>`. On failure, they throw an `Exception`.
/// The caller must handle errors using `try/catch`.
abstract class NotificationRepository {
  /// Retrieves notifications for a specific user or global notifications.
  /// Throws an [Exception] if the fetch fails.
  Stream<List<NotificationEntity>> getNotifications(String userId);

  /// Creates a new notification.
  /// Throws an [Exception] if creation fails.
  Future<void> createNotification(String userId, NotificationEntity notification);

  /// Deletes a specific notification.
  /// Throws an [Exception] if deletion fails.
  Future<void> deleteNotification(String userId, String notificationId);

  /// Marks a notification as read.
  /// Throws an [Exception] if the operation fails.
  Future<void> markNotificationAsRead(String userId, String notificationId);
}
