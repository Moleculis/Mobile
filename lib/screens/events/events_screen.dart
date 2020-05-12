import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/screens/create_edit_event/create_edit_event_screen.dart';
import 'package:moleculis/screens/events/widgets/events_list.dart';
import 'package:moleculis/services/events_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';

class EventsScreen extends StatefulWidget {
  final ShowSnackBar showErrorSnackBar;

  const EventsScreen({Key key, @required this.showErrorSnackBar})
      : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventsBloc eventsBloc;

  @override
  void didChangeDependencies() {
    eventsBloc = EventsBloc(eventsService: EventsService(HttpHelper()));
    eventsBloc.add(LoadEvents());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => eventsBloc,
      child: BlocListener<EventsBloc, EventsState>(
        bloc: eventsBloc,
        listener: (BuildContext context, EventsState state) {
          if (state is EventsFailure) {
            widget.showErrorSnackBar(state.error);
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: WidgetUtils.appBar(context,
                title: 'events'.tr().toLowerCase(),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'yours'.tr(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'others_events'.tr(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigation.toScreen(
                        context: context,
                        screen: CreateEditEventScreen(
                          eventsBloc: eventsBloc,
                        ),
                      );
                    },
                  ),
                ]),
            body: BlocBuilder<EventsBloc, EventsState>(
              bloc: eventsBloc,
              builder: (BuildContext context, EventsState eventsState) {
                if (eventsState.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SafeArea(
                  child: TabBarView(
                    children: <Widget>[
                      EventsList(
                        events: eventsState.events,
                      ),
                      EventsList(
                        events: eventsState.othersEvents,
                        others: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
