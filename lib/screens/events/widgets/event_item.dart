import 'package:flutter/material.dart';
import 'package:moleculis/models/event.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleTile(
      title: event.title,
      subtitle: event.description,
    );
  }
}
