import 'package:flutter/material.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/services/groups_service.dart';
import 'package:moleculis/services/http_helper.dart';

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
    return Container();
  }
}
