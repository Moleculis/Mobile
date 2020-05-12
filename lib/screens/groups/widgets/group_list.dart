import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/models/group/group.dart';
import 'package:moleculis/screens/groups/widgets/group_item.dart';

class GroupsList extends StatefulWidget {
  final List<Group> groups;

  const GroupsList({Key key, @required this.groups}) : super(key: key);

  @override
  _GroupsListState createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GroupsBloc groupsBloc;
  List<Group> groups;

  @override
  void initState() {
    groupsBloc = BlocProvider.of<GroupsBloc>(context);
    groups = widget.groups;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => groupsBloc.add(LoadGroups()),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GroupItem(
            group: groups[index],
          );
        },
        itemCount: groups.length,
      ),
    );
  }
}
