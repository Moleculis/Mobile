import 'package:meta/meta.dart';
import 'package:moleculis/models/group/group.dart';

@immutable
class GroupsState {
  final bool isLoading;
  final List<Group> groups;

  GroupsState({
    this.isLoading = false,
    this.groups = const [],
  });

  GroupsState copyWith({
    bool isLoading,
    List<Group> groups,
  }) {
    return GroupsState(
      isLoading: isLoading ?? this.isLoading,
      groups: groups ?? this.groups,
    );
  }
}

class GroupsFailure extends GroupsState {
  final String error;

  GroupsFailure({@required this.error}) : super();

  @override
  String toString() => 'GroupsFailure { error: $error }';
}

class GroupsSuccess extends GroupsState {
  final String message;

  GroupsSuccess({@required this.message}) : super();

  @override
  String toString() => 'GroupsSuccess { error: $message }';
}
