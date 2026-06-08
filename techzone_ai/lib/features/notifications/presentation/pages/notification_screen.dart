import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../providers/notification_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final Set<String> _processingIds = {};

  Future<void> _markAsRead(String notificationId) async {
    if (_processingIds.contains(notificationId)) return;
    
    setState(() => _processingIds.add(notificationId));
    try {
      await ref.read(notificationProvider.notifier).markAsRead(notificationId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingIds.remove(notificationId));
      }
    }
  }

  Future<void> _deleteNotification(String notificationId) async {
    if (_processingIds.contains(notificationId)) return;
    
    setState(() => _processingIds.add(notificationId));
    try {
      await ref.read(notificationProvider.notifier).deleteNotification(notificationId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingIds.remove(notificationId));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: notificationState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: AppTextStyles.bodyLg.copyWith(color: AppColors.error),
          ),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications available'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spaceMd),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final isProcessing = _processingIds.contains(notification.notificationId);

              return Container(
                decoration: BoxDecoration(
                  color: notification.isRead ? AppColors.surface : AppColors.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  border: Border.all(
                    color: notification.isRead ? AppColors.outlineVariant : AppColors.primary,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(AppDimensions.spaceMd),
                  leading: CircleAvatar(
                    backgroundColor: notification.isRead ? AppColors.surfaceContainerHigh : AppColors.primary,
                    child: Icon(
                      notification.isRead ? Icons.notifications_none : Icons.notifications_active,
                      color: notification.isRead ? AppColors.onSurfaceVariant : AppColors.onPrimary,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: AppTextStyles.titleMd.copyWith(
                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimensions.spaceXs),
                      Text(
                        notification.content,
                        style: AppTextStyles.bodyMd,
                      ),
                      const SizedBox(height: AppDimensions.spaceSm),
                      Text(
                        '${notification.createdAt.year}-${notification.createdAt.month.toString().padLeft(2, '0')}-${notification.createdAt.day.toString().padLeft(2, '0')} ${notification.createdAt.hour.toString().padLeft(2, '0')}:${notification.createdAt.minute.toString().padLeft(2, '0')}',
                        style: AppTextStyles.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                  trailing: isProcessing
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'read' && !notification.isRead) {
                              _markAsRead(notification.notificationId);
                            } else if (value == 'delete') {
                              _deleteNotification(notification.notificationId);
                            }
                          },
                          itemBuilder: (context) => [
                            if (!notification.isRead)
                              const PopupMenuItem(
                                value: 'read',
                                child: Text('Mark as read'),
                              ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete', style: TextStyle(color: AppColors.error)),
                            ),
                          ],
                        ),
                  onTap: () {
                    if (!notification.isRead) {
                      _markAsRead(notification.notificationId);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
