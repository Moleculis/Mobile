import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/screens/event_details/event_details_screen.dart';
import 'package:moleculis/utils/format.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final bool owned;

  const EventItem({
    Key? key,
    required this.event,
    required this.owned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventsBloc = BlocProvider.of<EventsBloc>(context);
    return SimpleTile(
      onTap: () {
        Navigation.toScreen(
          context: context,
          screen: EventDetailsScreen(
            eventId: event.id,
            owned: owned,
            eventsBloc: eventsBloc,
          ),
        );
      },
      title: event.title,
      subtitle: event.description,
      trailing: Text(
        FormatUtils.formatDateAndTime(event.date, context),
        style: TextStyle(
          color: DateTime.now().isAfter(event.date) ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
