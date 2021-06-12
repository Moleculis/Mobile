import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/screens/events/widgets/event_item.dart';
import 'package:moleculis/widgets/list_refresh.dart';

class EventsList extends StatefulWidget {
  final bool others;

  const EventsList({Key? key, this.others = false}) : super(key: key);

  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Event> events;

  late final EventsBloc eventsBloc;

  @override
  void initState() {
    eventsBloc = BlocProvider.of<EventsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<EventsBloc, EventsState>(
        bloc: eventsBloc,
        buildWhen: (prev, curr) {
          return !listEquals(prev.events, curr.events);
        },
        builder: (context, state) {
          events = (widget.others ? state.othersEvents : state.events)
              .where((Event event) => widget.others ? !event.private! : true)
              .toList();
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
        });
  }
}
