import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/notification_entity.dart';
import '../../../../core/di/providers.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class NotificationNotifier extends StreamNotifier<List<NotificationEntity>> {
  @override
  Stream<List<NotificationEntity>> build() {
    final user = ref.watch(authProvider).value;
    if (user == null) {
      return const Stream.empty();
    }
    return ref.read(notificationRepositoryProvider).getNotifications(user.uid);
  }

  Future<void> deleteNotification(String notificationId) async {
    final user = ref.read(authProvider).value;
    if (user == null) return;
    
    try {
      await ref.read(notificationRepositoryProvider).deleteNotification(user.uid, notificationId);
    } catch (e) {
      // Typically errors could be thrown, but we don't want to break the stream state
      // So we just log or bubble it up for UI to handle
      throw Exception('Failed to delete notification: $e');
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final user = ref.read(authProvider).value;
    if (user == null) return;
    
    try {
      await ref.read(notificationRepositoryProvider).markNotificationAsRead(user.uid, notificationId);
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }
}

final notificationProvider = StreamNotifierProvider<NotificationNotifier, List<NotificationEntity>>(NotificationNotifier.new);
