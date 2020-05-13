import 'package:equatable/equatable.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/models/user/user_small.dart';

abstract class GroupsEvent extends Equatable {}

class LoadGroups extends GroupsEvent {
  @override
  List<Object> get props => null;
}

class CreateGroupEvent extends GroupsEvent {
  final CreateUpdateGroupRequest request;
  final List<UserSmall> users;
  final List<UserSmall> admins;

  CreateGroupEvent(this.request, this.users, this.admins);

  @override
  List<Object> get props => [request, users, admins];
}

class UpdateGroupEvent extends GroupsEvent {
  final int groupId;
  final CreateUpdateGroupRequest request;
  final List<UserSmall> users;
  final List<UserSmall> admins;

  UpdateGroupEvent(this.request, this.users, this.admins, this.groupId);

  @override
  List<Object> get props => [request, users, admins, groupId];
}
