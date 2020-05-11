import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/screens/event_details/event_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final bool owned;

  const EventItem({Key key, @required this.event, this.owned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleTile(
      onTap: () {
        Navigation.toScreen(
          context: context,
          screen: BlocProvider(
            create: (BuildContext c) =>
                BlocProvider.of<EventsBloc>(context),
            child: EventDetailsScreen(eventId: event.id, owned: owned,),
          ),
        );
      },
      title: event.title,
      subtitle: event.description,
    );
  }
}
