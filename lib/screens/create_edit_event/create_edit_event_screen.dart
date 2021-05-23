import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/events/events_bloc.dart';
import 'package:moleculis/blocs/events/events_event.dart';
import 'package:moleculis/blocs/events/events_state.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/create_edit_event/widgets/users_search.dart';
import 'package:moleculis/screens/event_details/widgets/users_list.dart';
import 'package:moleculis/widgets/gradient_button.dart';
import 'package:moleculis/widgets/info_item.dart';
import 'package:moleculis/widgets/input.dart';
import 'package:moleculis/widgets/loading_wrapper.dart';
import 'package:moleculis/widgets/select_date_time.dart';
import 'package:moleculis/widgets/simple_button.dart';
import 'package:moleculis/widgets/toolbar.dart';

class CreateEditEventScreen extends StatefulWidget {
  final EventsBloc eventsBloc;
  final int? eventId;

  const CreateEditEventScreen({
    Key? key,
    required this.eventsBloc,
    this.eventId,
  }) : super(key: key);

  @override
  _CreateEditEventScreenState createState() => _CreateEditEventScreenState();
}

class _CreateEditEventScreenState extends State<CreateEditEventScreen> {
  late final EventsBloc eventsBloc;
  Event? event;
  User? currentUser;

  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();

  final TextEditingController locationController = TextEditingController();
  final FocusNode locationFocusNode = FocusNode();

  DateTime? date = DateTime.now();

  File? pickedImage;

  final List<UserSmall> newUsers = [];

  @override
  void initState() {
    eventsBloc = widget.eventsBloc;
    currentUser = BlocProvider.of<AuthBloc>(context).state.currentUser;
    if (widget.eventId != null) {
      event = eventsBloc.getEventById(widget.eventId!);
      titleController.text = event!.title;
      descriptionController.text = event!.description!;
      locationController.text = event!.location!;

      date = event!.date;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EventsBloc, EventsState>(
        bloc: eventsBloc,
        listener: (BuildContext context, EventsState state) {
          if (state is EventsSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, EventsState eventsState) {
          return LoadingWrapper(
            isLoading: eventsState.isLoading,
            child: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
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
                            title:
                                (event != null ? 'edit_event' : 'create_event')
                                    .tr(),
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
                            validator: (String? value) {
                              value = value!.trim();
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
                            validator: (String? value) {
                              value = value!.trim();
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
                            contentWidget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                UsersList(
                                  editing: true,
                                  onStateChane: () {
                                    setState(() {});
                                  },
                                  users: event?.users ?? newUsers,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: SimpleButton(
                                    text: '+',
                                    onPressed: onPickUsersTapped,
                                  ),
                                ),
                              ],
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
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> onPickUsersTapped() async {
    final User? resultUser = await showSearch<User?>(
      context: context,
      delegate: UserSearch(
        excludeUsername: event != null
            ? event!.users.map((e) => e.username).toList()
            : [currentUser!.username],
      ),
    );
    if (resultUser != null) {
      setState(() {
        (event?.users ?? newUsers).add(UserSmall.fromUser(resultUser));
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2050));
    if (picked != null && picked != date)
      setState(() {
        date = picked;
      });
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(date!),
    );
    if (picked != null && picked != TimeOfDay.fromDateTime(date!))
      setState(() {
        date = DateTime(
          date!.year,
          date!.month,
          date!.day,
          picked.hour,
          picked.minute,
        );
      });
  }

  void save() {
    if (formKey.currentState!.validate()) {
      final request = CreateUpdateEventRequest(
        title: titleController.text,
        description: descriptionController.text,
        location: locationController.text,
        date: date,
      );
      if (event == null) {
        eventsBloc.add(
          CreateEvent(
            request,
            newUsers,
          ),
        );
      } else {
        eventsBloc.add(
          UpdateEvent(
            widget.eventId!,
            request,
            event!.users
              ..where(
                (element) => element.username != currentUser!.username,
              ),
          ),
        );
      }
    }
  }
}
