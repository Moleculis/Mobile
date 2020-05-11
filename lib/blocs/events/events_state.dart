import 'package:meta/meta.dart';
import 'package:moleculis/models/event.dart';

@immutable
class EventsState {
  final bool isLoading;
  final List<Event> events;
  final List<Event> othersEvents;
  final int page;
  final int othersPage;
  final int pagesCount;
  final int othersPagesCount;

  EventsState({
    this.isLoading = false,
    this.events = const [],
    this.othersEvents = const [],
    this.page = 0,
    this.othersPage = 0,
    this.pagesCount = 1,
    this.othersPagesCount = 1,
  });

  EventsState copyWith({
    bool isLoading,
    List<Event> events,
    List<Event> othersEvents,
    int page,
    int othersPage,
    int pagesCount,
    int othersPagesCount,
  }) {
    return EventsState(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
      othersEvents: othersEvents ?? this.othersEvents,
      page: page ?? this.page,
      othersPage: othersPage ?? this.othersPage,
      pagesCount: pagesCount ?? this.pagesCount,
      othersPagesCount: othersPagesCount ?? this.othersPagesCount,
    );
  }
}

class EventsFailure extends EventsState {
  final String error;

  EventsFailure({@required this.error}) : super();

  @override
  String toString() => 'EventsFailure { error: $error }';
}
