import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../resourse/app_const.dart';
import '../resourse/app_shadow.dart';

class BaseTextFieldWidget extends StatelessWidget {
  const BaseTextFieldWidget({
    Key? key,
    this.mask,
    this.title,
    this.titleCenter = false,
    this.type,
    this.onChanged,
    this.onSaved,
    this.valid,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.initialValue,
    this.textInputAction,
    this.textCapitalization,
    this.autofocus,
    this.controller,
    this.backgroundColor,
    this.maxLines = 1,
    this.scrollPadding,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.autocorrect = true,
    this.focusNode,
    this.onTap,
    this.isAccentBorder = false,
    this.isAccentTitle = false,
    this.onEditingComplete,
    this.enabled = true,
    this.height = 40,
    this.autoFillHints,
  }) : super(key: key);
  final int? maxLines;
  final bool? autofocus;
  final String? autoFillHints;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final String? initialValue;
  final int? maxLength;
  final Color? backgroundColor;
  final String? hintText;
  final List<MaskTextInputFormatter>? mask;
  final String? title;
  final bool titleCenter;
  final TextInputType? type;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final double height;
  final EdgeInsets? scrollPadding;
  final bool autocorrect;
  final bool enabled;
  final bool obscureText;
  final bool isAccentBorder;
  final bool isAccentTitle;

  final Function(String value)? onChanged;
  final Function(String? value)? onSaved;
  final Function(String? value)? valid;
  final Function()? onEditingComplete;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          titleCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title ?? '',
                    maxLines: 1,
                    style: isAccentTitle
                        ? Theme.of(context).textTheme.bodyText1
                        : Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 4)
                ],
              )
            : const SizedBox(),
        Container(
          decoration: BoxDecoration(
            boxShadow: [AppShadow.shadowTextFieldLight],
          ),
          child: Stack(
            children: [
              TextFormField(
                autofillHints: autoFillHints != null ? [autoFillHints!] : null,
                textAlignVertical: TextAlignVertical.center,
                enabled: enabled,
                onEditingComplete: onEditingComplete,
                onTap: onTap,
                focusNode: focusNode,
                textAlign: textAlign,
                cursorColor: Theme.of(context).textTheme.bodyText2!.color,
                autocorrect: autocorrect,
                obscureText: obscureText,
                maxLines: maxLines,
                controller: controller,
                style: Theme.of(context).textTheme.bodyText2,
                initialValue: initialValue,
                keyboardType: type,
                autofocus: autofocus ?? false,
                decoration: getInputDecoration(
                  context,
                  hintText: hintText,
                  suffixIcon: suffixIcon,
                ),
                scrollPadding: scrollPadding ?? const EdgeInsets.all(20),
                maxLength: maxLength,
                inputFormatters: mask,
                validator: (input) {
                  if (valid != null) valid!(input);
                  return null;
                },
                onChanged: (value) {
                  if (onChanged != null) onChanged!(value);
                },
                onSaved: (value) {
                  if (onSaved != null) onSaved!(value ?? '');
                },
                textInputAction: textInputAction,
                textCapitalization:
                    textCapitalization ?? TextCapitalization.none,
              ),
            ],
          ),
        ),
      ],
    );
  }

  InputDecoration getInputDecoration(context,
      {String? hintText, String? labelText, Widget? suffixIcon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        right: suffixIcon != null
            ? titleCenter
                ? 36
                : 0
            : AppConst.paddingAll,
        left: suffixIcon != null
            ? titleCenter
                ? 36 + 32
                : 16
            : AppConst.paddingAll,
        top: 12,
        bottom: 12,
      ),
      filled: true,
      fillColor: backgroundColor ?? Theme.of(context).cardColor,
      prefixIcon: prefixIcon,
      hintText: hintText,
      suffixIcon: suffixIcon,
      labelText: labelText,
      counterText: '',
      suffixIconConstraints: BoxConstraints(minWidth: 32, maxHeight: height),
      constraints: BoxConstraints(maxHeight: height * maxLines!.toDouble()),
      hintStyle: Theme.of(context).textTheme.caption,
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
        borderSide: BorderSide(
          width: 1,
          color: Theme.of(context)
              .hintColor
              .withOpacity(isAccentBorder ? 0.5 : 0.1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
        borderSide: BorderSide(
          width: 1,
          color: Theme.of(context)
              .hintColor
              .withOpacity(isAccentBorder ? 0.5 : 0.1),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
        borderSide: BorderSide(
          width: 1,
          color: Theme.of(context).hintColor.withOpacity(0.1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.borderRadius),
        borderSide: BorderSide(
          width: 1,
          color: Theme.of(context)
              .hintColor
              .withOpacity(isAccentBorder ? 0.5 : 0.1),
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.caption,
    );
  }
}
