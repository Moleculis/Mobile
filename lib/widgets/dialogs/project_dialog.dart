import 'package:flutter/material.dart';

class ProjectDialog extends StatelessWidget {
  final String title;
  final String? text;
  final String positiveText;
  final bool withNegative;
  final VoidCallback? onPositiveTap;
  final EdgeInsets? insetPadding;
  final double borderRadius;

  const ProjectDialog({
    Key? key,
    required this.title,
    this.text,
    this.positiveText = 'OK',
    this.withNegative = false,
    this.onPositiveTap,
    this.insetPadding,
    this.borderRadius = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      insetPadding: insetPadding ??
          EdgeInsets.symmetric(
            vertical: 24,
            horizontal: screenWidth * 0.14,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (text != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      text!,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 24),
              ],
            ),
          ),
          _divider,
          _button(
            context,
            text: positiveText,
            onTap: onPositiveTap,
            isLast: !withNegative,
          ),
        ],
      ),
    );
  }

  Widget _button(
    BuildContext context, {
    required String text,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        onTap?.call();
        Navigator.pop(context);
      },
      borderRadius: isLast
          ? BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius),
              bottomRight: Radius.circular(borderRadius),
            )
          : BorderRadius.zero,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget get _divider {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.black.withOpacity(0.3),
    );
  }
}
