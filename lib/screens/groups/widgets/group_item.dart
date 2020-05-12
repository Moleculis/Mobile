import 'package:flutter/material.dart';
import 'package:moleculis/models/group/group.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class GroupItem extends StatelessWidget {
  final Group group;

  const GroupItem({Key key, @required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleTile(
      onTap: () {},
      title: group.title,
      subtitle: group.description,
    );
  }
}
