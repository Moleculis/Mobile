import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ListRefresh extends StatelessWidget {
  final Widget child;
  final FutureOr onRefresh;
  final bool? isNoItems;
  final String noItemsText;

  const ListRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    this.isNoItems = false,
    this.noItemsText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh as Future<void> Function(),
      child: isNoItems!
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(noItemsText),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: onRefresh as void Function()?,
                      child: Text(
                        'refresh'.tr(),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : child,
    );
  }
}
