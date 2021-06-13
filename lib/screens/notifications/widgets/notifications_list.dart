import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_event.dart';
import 'package:moleculis/blocs/notifications/notifications_state.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/screens/notifications/widgets/notification_entity_tile.dart';
import 'package:moleculis/utils/project_date_utils.dart';
import 'package:moleculis/utils/values/constants.dart';
import 'package:moleculis/utils/widget_utils.dart';

class NotificationsList extends StatefulWidget {
  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  late final ScrollController scrollController;
  late final NotificationsBloc notificationsBloc;

  bool loadingMore = false;

  @override
  void initState() {
    super.initState();
    notificationsBloc = context.read<NotificationsBloc>();

    scrollController = ScrollController()
      ..addListener(() {
        final notificationsState = notificationsBloc.state;
        final positionFromBottom = scrollController.position.maxScrollExtent -
            scrollController.position.pixels;
        if (!notificationsState.loadedAll &&
            !notificationsState.isLoadingMore &&
            !loadingMore &&
            positionFromBottom < 100) {
          loadingMore = true;
          notificationsBloc.add(LoadNotificationsEvent(isLoadMore: true));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (_, state) {
        if (!state.isLoadingMore && loadingMore) {
          loadingMore = false;
        }
        final notifications = state.notifications.toList();
        final List<NotificationModel> unreadNotifications =
            state.unreadNotifications;

        final int listLength =
            notifications.length + unreadNotifications.length;

        if (listLength == 0) {
          return Center(
            child: Text('no_new_activity'.tr()),
          );
        }

        notifications.insertAll(0, unreadNotifications);

        String? lastNotificationLabel = '';

        if (!state.loadedAll &&
            !state.isLoadingMore &&
            listLength < Constants.notificationsLimit) {
          loadingMore = true;
          notificationsBloc.add(LoadNotificationsEvent(isLoadMore: true));
        }
        return ListView.separated(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: listLength,
          separatorBuilder: (_, __) => Divider(height: 0.0),
          itemBuilder: (_, int index) {
            if (index == listLength) {
              return state.isLoadingMore
                  ? WidgetUtils.loadingIndicator(context)
                  : Container();
            }

            final notification = notifications[index];

            String? notificationTimeLabel = notification.isRead
                ? ProjectDateUtils.getDateDividerString(
                    notification.createdAt,
                  )
                : 'new'.plural(unreadNotifications.length);

            if (notificationTimeLabel != lastNotificationLabel) {
              lastNotificationLabel = notificationTimeLabel;
            } else {
              notificationTimeLabel = null;
            }

            return NotificationEntityTile(
              notificationEntity: notification,
              onNotificationTap: (notificationEntity) {},
              onDeleteNotification: (notificationEntity) {
                _onDeleteNotification(notificationEntity, notificationsBloc);
              },
            );
          },
        );
      },
    );
  }

  void _onDeleteNotification(
    NotificationModel notification,
    NotificationsBloc notificationsBloc,
  ) {
    notificationsBloc.add(DeleteNotificationEvent(notification));
  }
}
