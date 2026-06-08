import '../../domain/repositories/notification_repository.dart';
import '../../domain/entities/notification_entity.dart';
import '../models/notification_model.dart';
import '../datasources/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<NotificationEntity>> getNotifications(String userId) {
    return _remoteDataSource.getNotifications(userId)
        .map((models) => models.map((e) => e.toEntity()).toList());
  }

  @override
  Future<void> createNotification(String userId, NotificationEntity notification) async {
    final model = NotificationModel.fromEntity(notification);
    await _remoteDataSource.createNotification(userId, model);
  }

  @override
  Future<void> deleteNotification(String userId, String notificationId) async {
    await _remoteDataSource.deleteNotification(userId, notificationId);
  }

  @override
  Future<void> markNotificationAsRead(String userId, String notificationId) async {
    await _remoteDataSource.markNotificationAsRead(userId, notificationId);
  }
}
