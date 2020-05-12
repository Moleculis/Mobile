import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/groups/groups_event.dart';
import 'package:moleculis/blocs/groups/groups_state.dart';
import 'package:moleculis/models/group/group.dart';
import 'package:moleculis/models/page.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/services/groups_service.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final GroupsService _groupsService;

  GroupsBloc({GroupsService groupsService}) : _groupsService = groupsService;

  @override
  GroupsState get initialState => GroupsState();

  @override
  Stream<GroupsState> mapEventToState(GroupsEvent event) async* {
    if (event is LoadGroups) {}
  }

  Stream<GroupsState> _loadInitialData() async* {
    try {
      yield state.copyWith(isLoading: true);
      final Page groupsPage = await _groupsService.getGroupsPage(0);

      final List<Group> groups =
          groupsPage.content.map((e) => Group.fromMap(e)).toList();

      yield state.copyWith(
        isLoading: false,
        groups: groups,
      );
    } on AppException catch (e) {
      yield GroupsFailure(error: e.toString());
    }
  }
}
