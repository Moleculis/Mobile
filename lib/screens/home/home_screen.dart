import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/screens/more/more_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationBloc authenticationBloc;

  List<Widget> tabs = [
    Center(child: Text('Events screen'),),
    Center(child: Text('Groups screen'),),
    MoreScreen(),
  ];

  int currentTab = 0;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(LoadInitialData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab,
        children: tabs,
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
              icon: Icon(Icons.more),
              title: Text('more'.tr())
          )
        ],
      ),
    );
  }
}
