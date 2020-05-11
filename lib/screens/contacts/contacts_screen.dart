import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/models/contact/contact.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/screens/contacts/widgets/contacts_list.dart';
import 'package:moleculis/utils/widget_utils.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  AuthenticationBloc authenticationBloc;
  User currentUser;

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authenticationBloc.add(LoadInitialData());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: WidgetUtils.appBar(
          context,
          title: 'contact'.plural(2).toLowerCase(),
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
                  'requests'.tr(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator(),);
              }
              currentUser = state.currentUser;
              final List<Contact> contacts = [];
              final List<Contact> sentRequests = [];
              final List<Contact> contactRequests = [];
              for (Contact contact in currentUser.contacts) {
                if (contact.accepted) {
                  contacts.add(contact);
                } else {
                  sentRequests.add(contact);
                }
              }
              for (Contact contact in currentUser.contactRequests) {
                if (contact.accepted) {
                  contacts.add(contact);
                } else {
                  contactRequests.add(contact);
                }
              }
              return TabBarView(
                children: <Widget>[
                  ContactsList(
                    contacts: contacts,
                    sentRequests: sentRequests,
                  ),
                  ContactsList(
                    isReceived: true,
                    contacts: contactRequests,
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
