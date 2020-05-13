import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/screens/groups/widgets/group_item.dart';

class GroupsList extends StatelessWidget {

  final bool isOther;

  const GroupsList({Key key, this.isOther = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);
    return RefreshIndicator(
      onRefresh: () async => groupsBloc.add(LoadGroups()),
      child: BlocBuilder<GroupsBloc, GroupsState>(
          bloc: groupsBloc,
          builder: (BuildContext context, GroupsState state) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GroupItem(
                  group: isOther ? state.otherGroups[index] : state
                      .groups[index],
                );
              },
              itemCount: isOther ? state.otherGroups.length : state.groups
                  .length,
            );
          }
      ),
    );
  }
}
