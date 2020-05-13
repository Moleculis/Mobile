import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/models/group/group.dart';
import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/services/groups_service.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupsService _groupsService;

  GroupsBloc({GroupsService groupsService}) : _groupsService = groupsService;

  @override
  GroupsState get initialState => GroupsState();

  @override
  Stream<GroupsState> mapEventToState(GroupsEvent event) async* {
    if (event is LoadGroups) {
      yield* _loadInitialData();
    } else if (event is CreateGroupEvent) {
      yield* _createGroup(event.request, event.users, event.admins);
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

  Stream<GroupsState> _createGroup(CreateUpdateGroupRequest request,
      List<UserSmall> users,
      List<UserSmall> admins,) async* {
    try {
      yield state.copyWith(isLoading: true);
      final List<String> userNames = users.map((e) => e.username).toList();
      final List<String> adminNames = admins.map((e) => e.username).toList();
      request = request.copyWith(users: userNames, admins: adminNames);

      final String message = await _groupsService.createGroup(request);

      final GroupsState normalState = state.copyWith(
        groups: state.groups
          ..add(
            Group.fromRequest(request, users: users, admins: admins),
          ),
        isLoading: false,
      );
      yield GroupsSuccess(message: message);
      yield normalState;
    } on AppException catch (e) {
      yield GroupsFailure(error: e.toString());
    }
  }
}
