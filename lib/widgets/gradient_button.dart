import 'package:flutter/material.dart';
import 'package:moleculis/common/colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final Gradient? gradient;
  final double width;
  final double height;
  final Function? onPressed;
  final List<BoxShadow>? shadow;
  final Color? shadowColor;

  const GradientButton({
    Key? key,
    required this.text,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.shadow,
    this.shadowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(colors: [
              accentColor.withOpacity(0.9),
              accentColorDark.withOpacity(0.9)
            ], stops: [
              0.4,
              0.6
            ]),
        borderRadius: BorderRadius.circular(8),
        boxShadow: shadow ??
            [
              BoxShadow(
                color: shadowColor ?? Colors.grey[500]!,
                offset: Offset(0.0, 1.5),
                blurRadius: 1.5,
              ),
            ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed as void Function()?,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
