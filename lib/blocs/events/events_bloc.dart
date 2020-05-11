import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/models/page.dart';
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
}
