import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/screens/event_details/widgets/users_list.dart';
import 'package:moleculis/widgets/gradient_button.dart';
import 'package:moleculis/widgets/info_item.dart';
import 'package:moleculis/widgets/input.dart';
import 'package:moleculis/widgets/loading_widget.dart';
import 'package:moleculis/widgets/select_date_time.dart';
import 'package:moleculis/widgets/toolbar.dart';

class CreateEditEventScreen extends StatefulWidget {
  final int eventId;

  const CreateEditEventScreen({Key key, this.eventId}) : super(key: key);

  @override
  _CreateEditEventScreenState createState() => _CreateEditEventScreenState();
}

class _CreateEditEventScreenState extends State<CreateEditEventScreen> {
  EventsBloc eventsBloc;
  Event event;

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();

  final TextEditingController locationController = TextEditingController();
  final FocusNode locationFocusNode = FocusNode();

  DateTime date = DateTime.now();

  File pickedImage;

  @override
  void initState() {
    eventsBloc = BlocProvider.of<EventsBloc>(context);
    if (widget.eventId != null) {
      event = eventsBloc.getEventById(widget.eventId);
      titleController.text = event.title;
      descriptionController.text = event.description;
      locationController.text = event.location;

      date = event.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventsBloc, EventsState>(
      bloc: eventsBloc,
      listener: (BuildContext context, EventsState state) {
        if (state is EventsSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: BlocBuilder<EventsBloc, EventsState>(
            bloc: eventsBloc,
            builder: (BuildContext context, EventsState eventsState) {
              return SafeArea(
                child: Form(
                  key: formKey,
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Toolbar(
                                  title: 'edit_event'.tr(),
                                  backButton: true,
                                  onImagePicked: (File image) {
                                    pickedImage = image;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Input(
                                  controller: titleController,
                                  focusNode: titleFocusNode,
                                  nextFocusNode: descriptionFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {},
                                  validator: (String value) {
                                    value = value.trim();
                                    if (value.isEmpty) {
                                      return 'title_empty'.tr();
                                    }
                                    if (value.length < 5) {
                                      return 'title_short'.tr();
                                    }
                                    return null;
                                  },
                                  title: 'title'.tr(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Input(
                                  controller: descriptionController,
                                  focusNode: descriptionFocusNode,
                                  nextFocusNode: locationFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {},
                                  title: 'description'.tr(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Input(
                                  controller: locationController,
                                  focusNode: locationFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {},
                                  validator: (String value) {
                                    value = value.trim();
                                    if (value.isEmpty) {
                                      return 'location_empty'.tr();
                                    }
                                    if (value.length < 5) {
                                      return 'location_short'.tr();
                                    }
                                    return null;
                                  },
                                  title: 'location'.tr(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SelectDateTime(
                                  onTap: () => selectDate(context),
                                  selectedDate: date,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: SelectDateTime(
                                  onTap: () => selectTime(context),
                                  title: '${'time'.tr()}:',
                                  isTime: true,
                                  selectedDate: date,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InfoItem(
                                  title: 'participants'.tr(),
                                  contentWidget: UsersList(
                                    editing: true,
                                    onStateChane: () {
                                      setState(() {});
                                    },
                                    users: event.users,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: GradientButton(
                                  onPressed: save,
                                  text: 'save'.tr(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (eventsState.isLoading) LoadingWidget(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2050));
    if (picked != null && picked != date)
      setState(() {
        date = picked;
      });
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(date),
    );
    if (picked != null && picked != TimeOfDay.fromDateTime(date))
      setState(() {
        date = DateTime(
          date.year,
          date.month,
          date.day,
          picked.hour,
          picked.minute,
        );
      });
  }

  void save() {
    if (formKey.currentState.validate()) {
      final request = CreateUpdateEventRequest(
        title: titleController.text,
        description: descriptionController.text,
        location: locationController.text,
        date: date,
      );
      if (event == null) {
      } else {
        eventsBloc.add(
          UpdateEvent(
            widget.eventId,
            request,
            event.users
              ..where(
                (element) =>
                    element.username !=
                    BlocProvider.of<AuthenticationBloc>(context)
                        .state
                        .currentUser
                        .username,
              ),
          ),
        );
      }
    }
  }
}
