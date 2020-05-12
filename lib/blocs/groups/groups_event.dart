import 'package:equatable/equatable.dart';

abstract class GroupsEvent extends Equatable {}

class LoadGroups extends GroupsEvent {
  @override
  List<Object> get props => null;
}
