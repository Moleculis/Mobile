import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_event.dart';
import 'package:moleculis/blocs/notifications/notifications_state.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/services/apis/notifications_service.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/pagination/pagination_common.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsService _notificationService =
      locator<NotificationsService>();

  StreamSubscription<PaginationData<NotificationModel>?>?
      _notificationsSubscription;

  StreamSubscription<List<NotificationModel>?>?
      _unreadNotificationsSubscription;

  NotificationsBloc() : super(NotificationsState());

  @override
  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async* {
    if (event is LoadNotificationsEvent) {
      yield* _loadNotifications(isLoadMore: event.isLoadMore);
    } else if (event is ReadNotificationEvent) {
      yield* _readNotification(event.notification);
    } else if (event is ReadNotificationsEvent) {
      yield* _readNotifications(event.notifications!);
    } else if (event is DeleteNotificationEvent) {
      yield* _deleteNotification(event.notification);
    } else if (event is DeleteNotificationsEvent) {
      yield* _deleteNotifications(event.notifications);
    } else if (event is ClearNotificationsState) {
      yield* _clearState();
    } else if (event is ReadAllEvent) {
      yield* _readAll();
    }
  }

  Stream<NotificationsState> _loadNotifications({
    bool isLoadMore = false,
  }) async* {
    if (state.isLoading || state.isLoadingMore) return;
    if (isLoadMore) {
      yield state.copyWith(isLoadingMore: true);
    } else {
      yield state.copyWith(
        isLoading: true,
        loadedAll: false,
        notifications: [],
      );
    }
    try {
      if (_unreadNotificationsSubscription == null) {
        _unreadNotificationsSubscription =
            _notificationService.loadUnreadNotifications().listen(
          (notifications) {
            emit(state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              unreadNotifications: notifications,
            ));
          },
        );
      }

      _notificationsSubscription?.cancel();
      _notificationsSubscription = _notificationService
          .loadNotifications(
        isLoadMore: isLoadMore,
      )
          .listen((paginationData) {
        emit(state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          loadedAll: paginationData.loadedAll,
          notifications: paginationData.data,
        ));
      });
    } on Exception catch (e) {
      yield NotificationsFailure(error: e.toString());
    }
  }

  Stream<NotificationsState> _readNotification(
    NotificationModel notification,
  ) async* {
    try {
      if (!notification.isRead) {
        await _notificationService.readNotification(
          notificationId: notification.id,
        );
      }
    } on Exception catch (e) {
      yield NotificationsFailure(error: e.toString());
    }
  }

  Stream<NotificationsState> _readNotifications(
    List<NotificationModel> notifications,
  ) async* {
    try {
      await _notificationService.readNotifications(
        notifications: notifications,
      );
    } on Exception catch (e) {
      yield NotificationsFailure(error: e.toString());
    }
  }

  Stream<NotificationsState> _deleteNotification(
    NotificationModel notification,
  ) async* {
    try {
      await _notificationService.deleteNotification(
        notificationId: notification.id,
      );
    } on Exception catch (e) {
      yield NotificationsFailure(error: e.toString());
    }
  }

  Stream<NotificationsState> _deleteNotifications(
    List<NotificationModel> notifications,
  ) async* {
    try {
      await _notificationService.deleteNotifications(
        notifications: notifications,
      );
    } on Exception catch (e) {
      yield NotificationsFailure(error: e.toString());
    }
  }

  Stream<NotificationsState> _clearState() async* {
    try {
      _notificationsSubscription?.cancel();
      _unreadNotificationsSubscription = null;
      yield NotificationsState();
    } on Exception catch (error) {
      yield NotificationsFailure(error: error.toString());
    }
  }

  Stream<NotificationsState> _readAll() async* {
    try {
      await _notificationService.readNotifications(
        notifications: state.unreadNotifications,
      );
    } on Exception catch (error) {
      yield NotificationsFailure(error: error.toString());
    }
  }
}
