import 'package:equatable/equatable.dart';
import 'package:moleculis/models/notification/notification_model.dart';

abstract class NotificationsEvent extends Equatable {}

class InvitesButtonPressedEvent extends NotificationsEvent {
  final String string;

  InvitesButtonPressedEvent({required this.string});

  @override
  List<Object> get props => [string];
}

class LoadNotificationsEvent extends NotificationsEvent {
  final bool isLoadMore;

  LoadNotificationsEvent({this.isLoadMore = false});

  @override
  List<Object> get props => [isLoadMore];
}

class ListenNotificationsEvent extends NotificationsEvent {
  final List<NotificationModel> notifications;
  final bool? loadedAll;

  ListenNotificationsEvent({
    required this.notifications,
    this.loadedAll = false,
  });

  @override
  List<Object?> get props => [notifications, loadedAll];
}

class ListenUnreadNotificationsEvent extends NotificationsEvent {
  final List<NotificationModel> notifications;

  ListenUnreadNotificationsEvent({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}

class ReadNotificationEvent extends NotificationsEvent {
  final NotificationModel notification;

  ReadNotificationEvent(this.notification);

  @override
  List<Object> get props => [notification];
}

class ReadNotificationsEvent extends NotificationsEvent {
  final List<NotificationModel>? notifications;

  ReadNotificationsEvent(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class DeleteNotificationEvent extends NotificationsEvent {
  final NotificationModel notification;

  DeleteNotificationEvent(this.notification);

  @override
  List<Object> get props => [notification];
}

class DeleteNotificationsEvent extends NotificationsEvent {
  final List<NotificationModel> notifications;

  DeleteNotificationsEvent(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class ClearNotificationsState extends NotificationsEvent {
  @override
  List<Object> get props => [];
}

class ReadAllEvent extends NotificationsEvent {
  @override
  List<Object> get props => [];
}
