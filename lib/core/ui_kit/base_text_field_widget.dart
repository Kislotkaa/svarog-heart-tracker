import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

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
    this.onEditingComplete,
    this.enabled = true,
    this.height = 50,
    this.autoFillHints,
    this.cursorColor,
    this.style,
    this.hintStyle,
    this.titleStyle,
  }) : super(key: key);
  final int maxLines;
  final bool? autofocus;
  final String? autoFillHints;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final String? initialValue;
  final int? maxLength;
  final Color? backgroundColor;
  final Color? cursorColor;
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

  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;

  final Function(String value)? onChanged;
  final Function(String? value)? onSaved;
  final Function(String? value)? valid;
  final Function()? onEditingComplete;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: titleCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title ?? '',
                    maxLines: 1,
                    style:
                        titleStyle ?? appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                  ),
                  const SizedBox(height: 4)
                ],
              )
            : const SizedBox(),
        TextFormField(
          autofillHints: autoFillHints != null ? [autoFillHints!] : null,
          textAlignVertical: TextAlignVertical.center,
          enabled: enabled,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
          focusNode: focusNode,
          textAlign: textAlign,
          cursorColor: cursorColor ?? appTheme.textColor,
          autocorrect: autocorrect,
          obscureText: obscureText,
          maxLines: maxLines,
          controller: controller,
          style: style ?? appTheme.textTheme.bodySemibold16,
          initialValue: initialValue,
          keyboardType: type,
          autofocus: autofocus ?? false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              right: suffixIcon != null
                  ? titleCenter
                      ? 36
                      : 0
                  : 16,
              left: suffixIcon != null
                  ? titleCenter
                      ? 36 + 32
                      : 16
                  : 16,
              top: 12,
              bottom: 12,
            ),
            filled: true,
            fillColor: backgroundColor ?? appTheme.grayColor,
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintStyle: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.textGrayColor),
            labelStyle: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.textGrayColor),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1,
                color: appTheme.grayColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1,
                color: appTheme.grayColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1,
                color: appTheme.grayColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1,
                color: appTheme.textGrayColor.withOpacity(0.5),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: textInputAction,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
        ),
      ],
    );
  }
}
