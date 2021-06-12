import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_event.dart';
import 'package:moleculis/blocs/auth/auth_state.dart';
import 'package:moleculis/models/contact.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/screens/contacts/widgets/contacts_list.dart';
import 'package:moleculis/screens/contacts/widgets/users_list.dart';
import 'package:moleculis/utils/widget_utils.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late final AuthBloc authBloc;
  late User currentUser;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(ReloadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          context,
          title: 'contact'.plural(2).toLowerCase(),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
            bloc: authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              currentUser = state.currentUser!;
              final List<Contact> contacts = [];
              final List<Contact> sentRequests = [];
              final List<Contact> contactRequests = [];
              for (final contact in currentUser.contacts!) {
                if (contact.accepted) {
                  contacts.add(contact);
                } else {
                  sentRequests.add(contact);
                }
              }
              for (final contact in currentUser.contactRequests!) {
                if (contact.accepted) {
                  contacts.add(contact);
                } else {
                  contactRequests.add(contact);
                }
              }
              return Column(
                children: <Widget>[
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'yours'.tr(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'requests'.tr(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'others'.tr(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        ContactsList(
                          contacts: contacts,
                          sentRequests: sentRequests,
                        ),
                        ContactsList(
                          isReceived: true,
                          contacts: contactRequests,
                        ),
                        UsersList(users: state.otherUsers),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
