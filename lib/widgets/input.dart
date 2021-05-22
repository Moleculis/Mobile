import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? title;
  final TextInputType inputType;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? error;
  final String? hint;
  final bool isRequired;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool enabled;
  final bool isReadOnly;
  final bool hasBorder;
  final Function(String term)? onFieldSubmitted;
  final Function(String term)? onChanged;
  final Function(String? value)? onSaved;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? textInputFormatters;
  final Widget? prefix;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final Color? borderColor;
  final bool enableInteractiveSelection;

  const Input({
    Key? key,
    this.title,
    this.hint,
    this.error,
    this.padding,
    this.contentPadding,
    this.focusNode,
    this.nextFocusNode,
    this.onTap,
    this.controller,
    this.isReadOnly = false,
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
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputFormatters,
    this.hasBorder = true,
    this.prefix,
    this.prefixIcon,
    this.prefixText,
    this.prefixTextStyle,
    this.maxLines,
    this.minLines,
    this.borderColor,
    this.onChanged,
    this.enableInteractiveSelection = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.caption),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextFormField(
                validator: validator == null
                    ? (String s) {
                        if (isRequired) {
                          if (s.isEmpty) {
                            return '${title ?? hint ?? 'field'.tr()} ${'cannot_be_empty'.tr()}';
                          }
                        }
                        return null;
                      } as String? Function(String?)?
                    : validator,
                keyboardType: inputType,
                controller: controller,
                obscureText: obscureText,
                focusNode: focusNode,
                textCapitalization: textCapitalization,
                inputFormatters: textInputFormatters,
                onFieldSubmitted: (String text) {
                  onFieldSubmitted!(text);
                  focusNode!.unfocus();
                  if (nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(nextFocusNode);
                  }
                },
                enableInteractiveSelection: enableInteractiveSelection,
                onChanged: onChanged,
                onSaved: onSaved,
                maxLines: maxLines,
                minLines: minLines,
                enabled: enabled,
                textInputAction: textInputAction,
                style: TextStyle(
                  color: enabled ? Colors.black : Colors.grey,
                ),
                readOnly: isReadOnly,
                onTap: onTap,
                decoration: InputDecoration(
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 14,
                      ),
                  prefix: prefix,
                  prefixIcon: prefixIcon,
                  prefixText: prefixText,
                  prefixStyle: prefixTextStyle,
                  suffix: suffix,
                  suffixIcon: suffixIcon,
                  errorText: error,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor ?? Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: borderColor ?? Theme.of(context).accentColor),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  hintText: hint ?? '',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
