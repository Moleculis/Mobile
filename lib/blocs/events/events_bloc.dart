import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/services/events_service.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsService _eventsService;

  EventsBloc({EventsService eventsService}) : _eventsService = eventsService;

  @override
  EventsState get initialState => EventsState();

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is LoadEvents) {
      yield* _loadInitialData();
    } else if (event is UpdateEvent) {
      yield* _updateEvent(event.eventId, event.request, event.users);
    }
  }

  Stream<EventsState> _loadInitialData() async* {
    try {
      yield state.copyWith(isLoading: true);
      final Page eventsPage = await _eventsService.getEventsPage(0);
      final Page othersEventsPage = await _eventsService.getOthersEventsPage(0);

      final List<Event> events =
          eventsPage.content.map((e) => Event.fromMap(e)).toList();
      final List<Event> othersEvents =
          othersEventsPage.content.map((e) => Event.fromMap(e)).toList();

      yield state.copyWith(
        isLoading: false,
        pagesCount: eventsPage.size,
        othersPagesCount: othersEventsPage.size,
        events: events,
        othersEvents: othersEvents,
      );
    } on AppException catch (e) {
      yield EventsFailure(error: e.toString());
    }
  }

  Stream<EventsState> _updateEvent(int eventId,
      CreateUpdateEventRequest request,
      List<UserSmall> users,) async* {
    try {
      yield state.copyWith(isLoading: true);
      final List<String> userNames = users.map((e) => e.username).toList();
      request = request.copyWith(users: userNames);
      final String message = await _eventsService.updateEvent(eventId, request);
      yield* _updateLocalEventById(eventId, request, users);
      final EventsState normalState = state;
      yield EventsSuccess(message: message);
      yield normalState;
    } on AppException catch (e) {
      yield EventsFailure(error: e.toString());
    }
  }

  Stream<EventsState> _updateLocalEventById(int id,
      CreateUpdateEventRequest request, List<UserSmall> users) async* {
    final List<Event> newEvents = state.events;
    for (int i = 0; i < newEvents.length; ++i) {
      if (newEvents[i].id == id) {
        newEvents[i] = newEvents[i].copyWithRequest(request, users: users);
      }
    }
    yield state.copyWith(
      isLoading: false,
      events: newEvents,
    );
  }

  Event getEventById(int id) {
    for (Event event in state.events) {
      if (event.id == id) {
        return event;
      }
    }
    for (Event event in state.othersEvents) {
      if (event.id == id) {
        return event;
      }
    }

    return null;
  }
}
