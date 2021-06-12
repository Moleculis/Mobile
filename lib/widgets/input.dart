import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? title;
  final TextInputType inputType;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? error;
  final String? hint;
  final String? Function(String? text)? validator;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool enabled;
  final bool isRequired;
  final Function(String term)? onFieldSubmitted;
  final Function(String? value)? onSaved;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? textInputFormatters;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? helperText;
  final TextStyle? prefixTextStyle;
  final TextStyle? helperStyle;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final BorderRadius? borderRadius;
  final Color backgroundColor;
  final Color disabledBorderColor;
  final Color? activeBorderColor;
  final bool isDense;
  final VoidCallback? onTap;
  final int maxLines;
  final int minLines;
  final double? height;

  const Input({
    Key? key,
    required this.controller,
    this.title,
    this.hint,
    this.error,
    this.margin,
    this.padding,
    this.contentPadding,
    this.focusNode,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.suffix,
    this.suffixIcon,
    this.enabled = true,
    this.isRequired = false,
    this.onFieldSubmitted,
    this.onSaved,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textInputFormatters,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.helperText,
    this.prefixTextStyle,
    this.helperStyle,
    this.style,
    this.hintStyle,
    this.onChanged,
    this.nextFocusNode,
    this.borderRadius,
    this.backgroundColor = Colors.white,
    this.disabledBorderColor = Colors.grey,
    this.isDense = false,
    this.onTap,
    this.maxLines = 1,
    this.minLines = 1,
    this.height,
    this.activeBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.fromLTRB(12.0, 9.0, 12.0, 4.0),
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: focusNode!.hasFocus
              ? activeBorderColor ?? Theme.of(context).accentColor
              : disabledBorderColor,
        ),
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.caption),
          TextFormField(
            validator: validator == null
                ? (String? s) {
                    if (isRequired && (s == null || s.isEmpty)) {
                      return '${title ?? hint ?? 'Field'} cannot be empty';
                    }
                    return null;
                  }
                : validator,
            onChanged: onChanged,
            onTap: onTap,
            keyboardType: inputType,
            controller: controller,
            obscureText: obscureText,
            focusNode: focusNode,
            textCapitalization: textCapitalization,
            inputFormatters: textInputFormatters,
            onFieldSubmitted: (String text) {
              onFieldSubmitted?.call(text);
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            },
            maxLines: maxLines,
            minLines: minLines,
            onSaved: onSaved,
            enabled: enabled,
            textInputAction: textInputAction,
            style: style ??
                TextStyle(
                  color: enabled ? Colors.black : Colors.grey,
                ),
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
              prefix: prefix,
              isDense: isDense,
              prefixIcon: prefixIcon,
              prefixText: prefixText,
              prefixStyle: prefixTextStyle,
              suffix: suffix,
              suffixIcon: suffixIcon,
              errorText: error,
              hintText: hint ?? '',
              hintStyle: hintStyle,
              helperStyle: helperStyle,
              helperText: helperText,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
