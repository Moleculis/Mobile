import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/screens/events/events_screen.dart';
import 'package:moleculis/screens/groups/groups_screen.dart';
import 'package:moleculis/screens/more/more_screen.dart';
import 'package:moleculis/utils/widget_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationBloc authenticationBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  int currentTab = 0;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(LoadInitialData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      cubit: authenticationBloc,
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationFailure) {
          WidgetUtils.showErrorSnackbar(scaffoldKey, state.error);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: IndexedStack(
          index: currentTab,
          children: [
            EventsScreen(
              showErrorSnackBar: showErrorSnackBar,
            ),
            GroupsScreen(),
            MoreScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          currentIndex: currentTab,
          onTap: (int tab) {
            setState(() {
              currentTab = tab;
            });
          },
          selectedItemColor: accentColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text('events'.tr()),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('groups'.tr()),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.more), title: Text('more'.tr()))
          ],
        ),
      ),
    );
  }

  void showSuccessSnackBar(String message) {
    WidgetUtils.showSuccessSnackbar(scaffoldKey, message);
  }

  void showErrorSnackBar(String error) {
    WidgetUtils.showErrorSnackbar(scaffoldKey, error);
  }
}
