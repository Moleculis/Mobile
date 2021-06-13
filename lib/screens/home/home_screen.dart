import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_event.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/screens/events/events_screen.dart';
import 'package:moleculis/screens/groups/groups_screen.dart';
import 'package:moleculis/screens/more/more_screen.dart';
import 'package:moleculis/screens/notifications/notifications_screen.dart';
import 'package:moleculis/utils/notification_utils.dart';
import 'package:moleculis/utils/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      initNotifications();
    });
  }

  Future<void> initNotifications() async {
    final isNotificationsGranted = await NotificationUtils.requestPermission();
    if (isNotificationsGranted) {
      NotificationUtils.initNotificationService();
    }
    BlocProvider.of<NotificationsBloc>(context).add(LoadNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: [
          EventsScreen(showErrorSnackBar: showErrorSnackBar),
          GroupsScreen(),
          NotificationsScreen(),
          MoreScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: accentColor,
          canvasColor: backgroundColor,
        ),
        child: BottomNavigationBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          currentIndex: currentTab,
          onTap: (int tab) => setState(() => currentTab = tab),
          selectedItemColor: accentColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'events'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'groups'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'notifications'.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'more'.tr(),
            )
          ],
        ),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    WidgetUtils.showSuccessSnackbar(context, message: message);
  }

  void showErrorSnackBar(String error) {
    WidgetUtils.showErrorSnackbar(context, error: error);
  }
}
