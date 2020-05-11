import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/utils/format.dart';

class SelectDateTime extends StatefulWidget {
  final VoidCallback onTap;
  final DateTime selectedDate;
  final bool isTime;
  final String title;

  const SelectDateTime({
    Key key,
    this.onTap,
    this.selectedDate,
    this.title,
    this.isTime = false,
  }) : super(key: key);

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 36.0),
          child: Text(
            widget.title ?? '${'date'.tr()}:',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        InkWell(
          onTap: widget.onTap,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 28.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Text(
              widget.isTime
                  ? FormatUtils.formatTime(widget.selectedDate)
                  : FormatUtils.formatDate(widget.selectedDate),
            ),
          ),
        ),
      ],
    );
  }
}
