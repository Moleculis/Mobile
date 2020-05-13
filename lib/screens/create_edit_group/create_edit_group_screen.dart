import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/groups/groups_bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/models/group/group.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/create_edit_event/widgets/users_search.dart';
import 'package:moleculis/screens/event_details/widgets/users_list.dart';
import 'package:moleculis/widgets/gradient_button.dart';
import 'package:moleculis/widgets/info_item.dart';
import 'package:moleculis/widgets/input.dart';
import 'package:moleculis/widgets/loading_widget.dart';
import 'package:moleculis/widgets/toolbar.dart';

class CreateEditGroupScreen extends StatefulWidget {
  final int groupId;
  final GroupsBloc groupsBloc;

  const CreateEditGroupScreen({
    Key key,
    this.groupId,
    @required this.groupsBloc,
  }) : super(key: key);

  @override
  _CreateEditGroupScreenState createState() => _CreateEditGroupScreenState();
}

class _CreateEditGroupScreenState extends State<CreateEditGroupScreen> {
  Group group;
  User currentUser;
  GroupsBloc groupsBloc;

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();

  final List<UserSmall> newUsers = [];
  final List<UserSmall> newAdmins = [];

  File pickedImage;

  @override
  void initState() {
    groupsBloc = widget.groupsBloc;
    currentUser =
        BlocProvider.of<AuthenticationBloc>(context).state.currentUser;
    if (widget.groupId != null) {
      group = groupsBloc.getGroupById(widget.groupId);
      titleController.text = group.title;
      descriptionController.text = group.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupsBloc, GroupsState>(
      bloc: groupsBloc,
      listener: (BuildContext context, GroupsState state) {
        if (state is GroupsSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: BlocBuilder<GroupsBloc, GroupsState>(
            bloc: groupsBloc,
            builder: (BuildContext context, GroupsState eventsState) {
              return SafeArea(
                child: Form(
                  key: formKey,
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Toolbar(
                                  title: (group != null
                                          ? 'edit_group'
                                          : 'create_group')
                                      .tr(),
                                  backButton: true,
                                  onImagePicked: (File image) {
                                    pickedImage = image;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Input(
                                  controller: titleController,
                                  focusNode: titleFocusNode,
                                  nextFocusNode: descriptionFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {},
                                  validator: (String value) {
                                    value = value.trim();
                                    if (value.isEmpty) {
                                      return 'title_empty'.tr();
                                    }
                                    if (value.length < 5) {
                                      return 'title_short'.tr();
                                    }
                                    return null;
                                  },
                                  title: 'title'.tr(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Input(
                                  controller: descriptionController,
                                  focusNode: descriptionFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {},
                                  title: 'description'.tr(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InfoItem(
                                  title: 'participants'.tr(),
                                  contentWidget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      UsersList(
                                        editing: true,
                                        onStateChane: () {
                                          setState(() {});
                                        },
                                        users: group?.users ?? newUsers,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          child: Text('+'),
                                          onPressed: onPickUsersTapped,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InfoItem(
                                  title: 'admins'.tr(),
                                  contentWidget: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      UsersList(
                                        editing: true,
                                        showCurrentUser: true,
                                        onStateChane: () {
                                          setState(() {});
                                        },
                                        users: group?.admins ?? newAdmins,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          child: Text('+'),
                                          onPressed: () =>
                                              onPickUsersTapped(isAdmins: true),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: GradientButton(
                                  onPressed: save,
                                  text: 'save'.tr(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (eventsState.isLoading) LoadingWidget(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> onPickUsersTapped({bool isAdmins = false}) async {
    List<String> excludeUsers;
    if (group != null) {
      excludeUsers = (isAdmins ? group.admins : group.users)
          .map((e) => e.username)
          .toList();
      excludeUsers.addAll((isAdmins ? group.users : group.admins)
          .map((e) => e.username)
          .toList());
      if (!excludeUsers.contains(currentUser.username)) {
        excludeUsers.add(currentUser.username);
      }
    } else {
      excludeUsers = [currentUser.username];
    }

    final User resultUser = await showSearch(
      context: context,
      delegate: UserSearch(
        excludeUsername: excludeUsers,
      ),
    );
    if (resultUser != null) {
      setState(() {
        if (isAdmins) {
          (group?.admins ?? newAdmins).add(UserSmall.fromUser(resultUser));
        } else {
          (group?.users ?? newUsers).add(UserSmall.fromUser(resultUser));
        }
      });
    }
  }

  void save() {
    if (formKey.currentState.validate()) {
      final CreateUpdateGroupRequest request = CreateUpdateGroupRequest(
        title: titleController.text,
        description: descriptionController.text,
      );
      newAdmins.add(UserSmall.fromUser(currentUser));
      if (group == null) {
        groupsBloc.add(CreateGroupEvent(request, newUsers, newAdmins));
      } else {
        groupsBloc.add(
            UpdateGroupEvent(request, group.users, group.admins, group.id));
      }
    }
  }
}
