import 'package:flutter/material.dart';
import 'package:moleculis/utils/locale_utils.dart';

class LanguageItem extends StatelessWidget {
  final VoidCallback? onTap;
  final LocaleItem localeItem;

  const LanguageItem({
    Key? key,
    required this.localeItem,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Image.asset(localeItem.imageAsset),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(localeItem.name),
            ),
          ],
        ),
      ),
    );
  }
}
