import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/utils/pagination/pagination_common.dart';

abstract class NotificationsService {
  Stream<PaginationData<NotificationModel>> loadNotifications({
    bool isLoadMore = false,
  });

  Stream<List<NotificationModel>> loadUnreadNotifications();

  Future<void> createNotification(NotificationModel notification);

  Future<void> readNotification({
    required String notificationId,
  });

  Future<void> readNotifications({
    required List<NotificationModel> notifications,
  });

  Future<void> deleteNotification({required String notificationId});

  Future<void> deleteNotifications({
    required List<NotificationModel> notifications,
  });
}
