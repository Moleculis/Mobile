import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/widgets/dialogs/bottom_dialog_button.dart';

class BottomDialog extends StatelessWidget {
  final List<BottomDialogButton> buttons;
  final String? title;

  const BottomDialog({
    Key? key,
    required this.buttons,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 20.0, 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? 'choose_option'.tr(),
                    style: TextStyle(color: Colors.grey.withOpacity(0.4)),
                  ),
                  IconButton(
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                        Icon(Icons.close),
                      ],
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            ...buttons,
          ],
        ),
      ),
    );
  }
}
