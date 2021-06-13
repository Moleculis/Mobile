import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_event.dart';
import 'package:moleculis/blocs/notifications/notifications_state.dart';
import 'package:moleculis/screens/notifications/widgets/notifications_list.dart';
import 'package:moleculis/screens/notifications/widgets/read_all_button.dart';
import 'package:moleculis/utils/widget_utils.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationsBloc notificationsBloc;

  @override
  void initState() {
    super.initState();
    notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.appBar(
        context,
        title: 'notifications'.tr().toLowerCase(),
        actions: [readAllButton()],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [Divider(height: 0.0), Expanded(child: NotificationsList())],
    );
  }

  void onReadAll() => notificationsBloc.add(ReadAllEvent());

  Widget readAllButton() {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      bloc: notificationsBloc,
      builder: (_, state) {
        if (state.unreadCount > 0) return ReadAllButton(onReadAll: onReadAll);
        return Container();
      },
    );
  }
}
