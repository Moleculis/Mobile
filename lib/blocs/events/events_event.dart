import 'package:equatable/equatable.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/models/user/user_small.dart';

abstract class EventsEvent extends Equatable {}

class LoadEvents extends EventsEvent {
  @override
  List<Object> get props => null;
}

class UpdateEvent extends EventsEvent {
  final int eventId;
  final CreateUpdateEventRequest request;
  final List<UserSmall> users;

  UpdateEvent(this.eventId, this.request, this.users);

  @override
  List<Object> get props => [eventId, request, users];
}

class CreateEvent extends EventsEvent {
  final CreateUpdateEventRequest request;
  final List<UserSmall> users;

  CreateEvent(this.request, this.users);

  @override
  List<Object> get props => [request, users];
}
