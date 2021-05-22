import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/screens/group_details/group_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class GroupItem extends StatelessWidget {
  final Group group;

  const GroupItem({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsBloc = BlocProvider.of<GroupsBloc>(context);
    return SimpleTile(
      onTap: () {
        Navigation.toScreen(
          context: context,
          screen: GroupDetailsScreen(
            groupId: group.id,
            groupsBloc: groupsBloc,
          ),
        );
      },
      title: group.title,
      subtitle: group.description,
    );
  }
}
