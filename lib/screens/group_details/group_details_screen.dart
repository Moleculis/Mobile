import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/models/group/group.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/create_edit_group/create_edit_group_screen.dart';
import 'package:moleculis/screens/event_details/widgets/users_list.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/big_tile.dart';
import 'package:moleculis/widgets/info_item.dart';

class GroupDetailsScreen extends StatefulWidget {
  final int groupId;
  final GroupsBloc groupsBloc;

  const GroupDetailsScreen({
    Key key,
    @required this.groupId,
    this.groupsBloc,
  }) : super(key: key);

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  GroupsBloc groupsBloc;

  @override
  void initState() {
    groupsBloc = widget.groupsBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Group group = groupsBloc.getGroupById(widget.groupId);
    final User currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.currentUser;
    bool isAdmin = false;
    for (UserSmall user in group.admins) {
      if (user.username == currentUser.username) {
        isAdmin = true;
        break;
      }
    }
    return Scaffold(
      appBar: WidgetUtils.appBar(
        context,
        title: 'group_details'.tr().toLowerCase(),
        actions: [
          if (isAdmin)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                Navigation.toScreen(
                  context: context,
                  screen: CreateEditGroupScreen(
                    groupsBloc: groupsBloc,
                    groupId: group.id,
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GroupsBloc, GroupsState>(
          bloc: groupsBloc,
          builder: (BuildContext context, GroupsState state) {
            final Group group = groupsBloc.getGroupById(widget.groupId);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BigTile(
                      title: group.title,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InfoItem(
                      title: 'description'.tr(),
                      content: group.description,
                    ),
                  ),
                  InfoItem(
                    title: 'participants'.tr(),
                    contentWidget: UsersList(
                      users: group.users,
                    ),
                  ),
                  InfoItem(
                    title: 'admins'.tr(),
                    contentWidget: UsersList(
                      showCurrentUser: true,
                      users: group.admins,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
