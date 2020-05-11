import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/models/contact/contact.dart';
import 'package:moleculis/screens/contacts/widgets/contact_item.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/custom_expansion_tile.dart';

class ContactsList extends StatefulWidget {
  final List<Contact> contacts;
  final List<Contact> sentRequests;
  final bool isReceived;

  const ContactsList({
    Key key,
    this.contacts,
    this.sentRequests,
    this.isReceived = false,
  }) : super(key: key);

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AuthenticationBloc authenticationBloc;

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => authenticationBloc.add(LoadInitialData()),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            if (widget.sentRequests != null && widget.sentRequests.isNotEmpty) {
              return CustomExpansionTile(
                title: Text('sent_requests'.tr()),
                content: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ContactItem(
                        onRemove: deleteContact,
                        contact: widget.sentRequests[index],
                      ),
                    );
                  },
                  itemCount: widget.sentRequests.length,
                ),
              );
            }
            return Container();
          }
          final Contact contact = widget.contacts[index - 1];
          return ContactItem(
            contact: contact,
            onRemove: deleteContact,
            onAccept:
            widget.isReceived ? (int id) => acceptContact(contact) : null,
            isReceived: widget.isReceived,
          );
        },
        itemCount: widget.contacts.length + 1,
      ),
    );
  }

  void deleteContact(int id) {
    WidgetUtils.showSimpleDialog(
      context: context,
      title: 'remove_contact_confirm'.tr(),
      onYes: () {
        authenticationBloc.add(RemoveContactEvent(id));
      },
    );
  }

  void acceptContact(Contact contact) {
    WidgetUtils.showSimpleDialog(
      context: context,
      title: 'accept_contact_confirm'.tr(args: [contact.user.username]),
      onYes: () {
        authenticationBloc.add(AcceptContactEvent(contact.id));
      },
    );
  }
}
