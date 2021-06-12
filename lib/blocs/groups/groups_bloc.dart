import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/services/apis/groups_service.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/utils/locator.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupsService _groupsService = locator<GroupsService>();

  GroupsBloc() : super(GroupsState());

  @override
  Stream<GroupsState> mapEventToState(GroupsEvent event) async* {
    if (event is LoadGroups) {
      yield* _loadInitialData();
    } else if (event is CreateGroupEvent) {
      yield* _createGroup(event.request, event.users, event.admins);
    } else if (event is UpdateGroupEvent) {
      yield* _updateGroup(
        event.request,
        event.users ?? [],
        event.admins ?? [],
        event.groupId,
      );
    }
  }

  Stream<GroupsState> _loadInitialData() async* {
    try {
      yield state.copyWith(isLoading: true);
      final Page groupsPage = await _groupsService.getGroupsPage(0);
      final Page otherGroupsPage = await _groupsService.getOtherGroupsPage(0);

      final List<Group> groups =
          groupsPage.content.map((e) => Group.fromMap(e)).toList();

      final List<Group> otherGroups =
          otherGroupsPage.content.map((e) => Group.fromMap(e)).toList();

      yield state.copyWith(
          isLoading: false, groups: groups, otherGroups: otherGroups);
    } on AppException catch (e) {
      yield GroupsFailure(error: e.toString());
    }
  }

  Stream<GroupsState> _createGroup(
    CreateUpdateGroupRequest request,
    List<UserSmall> users,
    List<UserSmall> admins,
  ) async* {
    try {
      yield state.copyWith(isLoading: true);
      final List<String> userNames = users.map((e) => e.username).toList();
      final List<String> adminNames = admins.map((e) => e.username).toList();
      request = request.copyWith(users: userNames, admins: adminNames);

      final String? message = await _groupsService.createGroup(request);

      yield GroupsSuccess(message: message);
      yield* _loadInitialData();
    } on AppException catch (e) {
      yield GroupsFailure(error: e.toString());
    }
  }

  Stream<GroupsState> _updateGroup(
    CreateUpdateGroupRequest request,
    List<UserSmall> users,
    List<UserSmall> admins,
    int groupId,
  ) async* {
    try {
      yield state.copyWith(isLoading: true);
      final List<String> userNames = users.map((e) => e.username).toList();
      final List<String> adminNames = admins.map((e) => e.username).toList();
      request = request.copyWith(users: userNames, admins: adminNames);

      final String? message =
          await _groupsService.updateGroup(groupId, request);
      Group newGroup = getGroupById(groupId)!;
      newGroup = newGroup.copyWithRequest(request, users, admins);
      final List<Group> newGroups = state.groups;
      for (int i = 0; i < newGroups.length; ++i) {
        final group = newGroups[i];
        if (group.id == newGroup.id) {
          newGroups[i] = newGroup;
        }
      }
      final normalState = state.copyWith(
        groups: newGroups,
        isLoading: false,
      );
      yield GroupsSuccess(message: message);
      yield normalState;
    } on AppException catch (e) {
      yield GroupsFailure(error: e.toString());
    }
  }

  Group? getGroupById(int groupId) {
    for (final group in state.groups) {
      if (group.id == groupId) {
        return group;
      }
    }
    for (final group in state.otherGroups) {
      if (group.id == groupId) {
        return group;
      }
    }
    return null;
  }
}
