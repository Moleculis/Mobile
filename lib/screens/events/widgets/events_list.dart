import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/screens/events/widgets/event_item.dart';
import 'package:moleculis/widgets/list_refresh.dart';

class EventsList extends StatefulWidget {
  final List<Event> events;
  final bool others;

  const EventsList({Key? key, required this.events, this.others = false})
      : super(key: key);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final List<Event> events;

  late final EventsBloc eventsBloc;

  @override
  void initState() {
    eventsBloc = BlocProvider.of<EventsBloc>(context);
    events = widget.events
        .where((Event event) => widget.others ? !event.private! : true)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListRefresh(
      onRefresh: () async => eventsBloc.add(LoadEvents()),
      isNoItems: events.isEmpty,
      noItemsText: 'no_events'.tr(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return EventItem(
            owned: !widget.others,
            event: events[index],
          );
        },
        itemCount: events.length,
      ),
    );
  }
}
