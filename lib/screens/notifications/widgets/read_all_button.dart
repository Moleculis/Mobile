import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReadAllButton extends StatelessWidget {
  final VoidCallback? onReadAll;

  const ReadAllButton({Key? key, required this.onReadAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20.0);
    final color = Theme.of(context).accentColor;
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius, border: Border.all(color: color)),
        constraints: BoxConstraints(maxWidth: 120),
        margin: const EdgeInsets.only(right: 10.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onReadAll,
            borderRadius: borderRadius,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 8.0),
              child: Text(
                'read_all'.tr(),
                style: TextStyle(color: color, fontSize: 10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
