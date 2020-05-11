import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/utils/widget_utils.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.appBar(
        context,
        title: 'contact'.plural(2),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
