import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/utils/locale_utils.dart';

class LocaleWidget extends StatelessWidget {
  final bool showLanguageName;
  final LocaleItem localeItem;

  const LocaleWidget({
    Key? key,
    required this.localeItem,
    this.showLanguageName = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 30,
          height: 24,
          child: Image.asset(localeItem.imageAsset),
        ),
        if (showLanguageName)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(localeItem.name),
          ),
      ],
    );
  }
}
