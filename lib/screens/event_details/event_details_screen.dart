import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/big_tile.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;

  const EventDetailsScreen({Key key, @required this.eventId}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventsBloc eventsBloc;

  @override
  void initState() {
    eventsBloc = BlocProvider.of<EventsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.appBar(context,
          title: 'event_details'.tr().toLowerCase()),
      body: SingleChildScrollView(
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (BuildContext context, EventsState state) {
            final Event event = eventsBloc.getEventById(widget.eventId);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  BigTile(
                    title: event.title,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
