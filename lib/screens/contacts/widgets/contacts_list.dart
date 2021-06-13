import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_event.dart';
import 'package:moleculis/models/contact.dart';
import 'package:moleculis/screens/contacts/widgets/contact_item.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/custom_expansion_tile.dart';
import 'package:moleculis/widgets/list_refresh.dart';

class ContactsList extends StatefulWidget {
  final List<Contact> contacts;
  final List<Contact>? sentRequests;
  final bool isReceived;

  const ContactsList({
    Key? key,
    required this.contacts,
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

  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListRefresh(
      onRefresh: () async => authBloc.add(ReloadUserEvent()),
      isNoItems:
          widget.contacts.isEmpty && (widget.sentRequests?.isEmpty ?? true),
      noItemsText:
          widget.isReceived ? 'no_contact_requests'.tr() : 'no_contacts'.tr(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            if (widget.sentRequests != null &&
                widget.sentRequests!.isNotEmpty) {
              return CustomExpansionTile(
                title: Text('sent_requests'.tr()),
                initialExpanded: true,
                content: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ContactItem(
                        onRemove: deleteContact,
                        contact: widget.sentRequests![index],
                      ),
                    );
                  },
                  itemCount: widget.sentRequests!.length,
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
        authBloc.add(RemoveContactEvent(id));
      },
    );
  }

  void acceptContact(Contact contact) {
    WidgetUtils.showSimpleDialog(
      context: context,
      title: 'accept_contact_confirm'.tr(args: [contact.user.username]),
      onYes: () {
        authBloc.add(AcceptContactEvent(contact.id));
      },
    );
  }
}
