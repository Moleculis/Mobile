import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/screens/create_edit_group/create_edit_group_screen.dart';
import 'package:moleculis/screens/groups/widgets/group_list.dart';
import 'package:moleculis/services/groups_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  GroupsBloc groupsBloc;

  @override
  void didChangeDependencies() {
    groupsBloc = GroupsBloc(groupsService: GroupsService(HttpHelper()));
    groupsBloc.add(LoadGroups());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupsBloc>(
      create: (BuildContext context) => groupsBloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: WidgetUtils.appBar(context,
              title: 'groups'.tr().toLowerCase(),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'yours'.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'other_groups'.tr(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigation.toScreen(
                      context: context,
                      screen: CreateEditGroupScreen(
                        groupsBloc: groupsBloc,
                      ),
                    );
                  },
                ),
              ]),
          body: BlocBuilder<GroupsBloc, GroupsState>(
            cubit: groupsBloc,
            builder: (BuildContext context, GroupsState groupsState) {
              if (groupsState.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SafeArea(
                child: TabBarView(
                  children: <Widget>[
                    GroupsList(),
                    GroupsList(
                      isOther: true,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
