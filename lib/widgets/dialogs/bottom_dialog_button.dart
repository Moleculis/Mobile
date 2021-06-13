import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BottomDialogButton extends StatelessWidget {
  final String? text;
  final TextSpan? textSpan;
  final IconData? icon;
  final Widget? customIcon;
  final Widget? action;
  final Color accentColor;
  final VoidCallback? onTap;
  final AutoSizeGroup? autoSizeGroup;
  final EdgeInsets padding;

  const BottomDialogButton({
    Key? key,
    this.text,
    this.textSpan,
    this.icon,
    this.customIcon,
    this.action,
    this.accentColor = Colors.black,
    this.onTap,
    this.autoSizeGroup,
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(text != null || textSpan != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(color: accentColor);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 60.0,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              padding: padding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(0.3)),
              child: customIcon ?? Icon(icon, size: 20.0, color: accentColor),
            ),
            Expanded(
              child: text != null
                  ? AutoSizeText(
                      text!,
                      style: textStyle,
                      group: autoSizeGroup,
                      maxLines: 1,
                      minFontSize: 12.0,
                      maxFontSize: 14.0,
                    )
                  : RichText(
                      text: TextSpan(style: textStyle, children: [textSpan!]),
                      maxLines: 1,
                    ),
            ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
