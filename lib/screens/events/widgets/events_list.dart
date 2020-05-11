import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/screens/events/widgets/event_item.dart';

class EventsList extends StatefulWidget {
  final List<Event> events;
  final bool others;

  const EventsList({Key key, @required this.events, this.others = false})
      : super(key: key);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Event> events;

  EventsBloc eventsBloc;

  @override
  void initState() {
    eventsBloc = BlocProvider.of<EventsBloc>(context);
    events = widget.events
        .where((Event event) => widget.others ? !event.private : true)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => eventsBloc.add(LoadEvents()),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return EventItem(
            event: events[index],
          );
        },
        itemCount: events.length,
      ),
    );
  }
}
