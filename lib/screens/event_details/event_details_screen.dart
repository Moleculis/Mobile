import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/screens/create_edit_event/create_edit_event_screen.dart';
import 'package:moleculis/screens/event_details/widgets/users_list.dart';
import 'package:moleculis/utils/format.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/big_tile.dart';
import 'package:moleculis/widgets/info_item.dart';

class EventDetailsScreen extends StatefulWidget {
  final int eventId;
  final bool owned;

  const EventDetailsScreen({
    Key key,
    @required this.eventId,
    this.owned,
  }) : super(key: key);

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
      appBar: WidgetUtils.appBar(
        context,
        title: 'event_details'.tr().toLowerCase(),
        actions: [
          if (widget.owned)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigation.toScreen(
                  context: context,
                  screen: BlocProvider(
                    create: (BuildContext context) => eventsBloc,
                    child: CreateEditEventScreen(eventId: widget.eventId,),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<EventsBloc, EventsState>(
          builder: (BuildContext context, EventsState state) {
            final Event event = eventsBloc.getEventById(widget.eventId);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BigTile(
                      title: event.title,
                      subtitle:
                      'Created: ${FormatUtils.formatDateAndTime(
                          event.dateCreated)}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InfoItem(
                      title: 'description'.tr(),
                      content: event.description,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InfoItem(
                      title: 'date'.tr(),
                      content: FormatUtils.formatDateAndTime(event.date),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InfoItem(
                      title: 'location'.tr(),
                      content: event.location,
                    ),
                  ),
                  InfoItem(
                    title: 'participants'.tr(),
                    contentWidget: UsersList(
                      users: event.users,
                    ),
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
