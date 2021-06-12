import 'package:meta/meta.dart';
import 'package:moleculis/models/notification/notification_model.dart';

@immutable
class NotificationsState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool loadedAll;
  final bool isUpdating;
  final bool isShowNotification;
  final List<NotificationModel> notifications;
  final List<NotificationModel> unreadNotifications;
  final NotificationModel? newNotification;

  NotificationsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.loadedAll = false,
    this.isUpdating = false,
    this.isShowNotification = false,
    this.notifications = const <NotificationModel>[],
    this.unreadNotifications = const <NotificationModel>[],
    this.newNotification,
  });

  NotificationsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? loadedAll,
    bool? isUpdating,
    bool? isShowNotification,
    List<NotificationModel>? notifications,
    List<NotificationModel>? unreadNotifications,
    NotificationModel? newNotification,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadedAll: loadedAll ?? this.loadedAll,
      isUpdating: isUpdating ?? this.isUpdating,
      isShowNotification: isShowNotification ?? this.isShowNotification,
      notifications: notifications ?? this.notifications,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
      newNotification: newNotification ?? this.newNotification,
    );
  }

  int get unreadCount => unreadNotifications.length;
}

class NotificationsFailure extends NotificationsState {
  final String error;

  NotificationsFailure({required this.error}) : super();

  @override
  String toString() => 'NotificationsFailure { error: $error }';
}
