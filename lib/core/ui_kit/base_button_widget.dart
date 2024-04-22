import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseButtonWidget extends StatelessWidget {
  const BaseButtonWidget({
    Key? key,
    this.child,
    this.onPressed,
    this.rightChild,
    this.height = 50,
    this.width = double.infinity,
    this.color,
    this.textColor,
    this.isOutLine = false,
    this.visualFeedBack = false,
    this.phisicalFeedBack = false,
    this.margin,
  }) : super(key: key);
  final Widget? child;
  final Widget? rightChild;
  final Function? onPressed;
  final double? height;
  final Color? color;
  final Color? textColor;
  final bool isOutLine;
  final double? width;
  final EdgeInsets? margin;

  final bool visualFeedBack;
  final bool phisicalFeedBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      height: height,
      width: width,
      child: isOutLine
          ? OutlinedButton(
              style: buttonOutLineStyle(context),
              onPressed: () {
                if (phisicalFeedBack) HapticFeedback.mediumImpact();
                onPressed?.call();
              },
              child: rightChild == null
                  ? child ?? const Text('')
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        child ?? const SizedBox(),
                        rightChild ?? const SizedBox(),
                      ],
                    ),
            )
          : MaterialButton(
              shape: getShape,
              elevation: 0,
              disabledColor: appTheme.primaryColor.withOpacity(0.4),
              splashColor: visualFeedBack ? appTheme.primaryColor : Colors.transparent,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: visualFeedBack ? 3 : 0,
              color: color ?? appTheme.revertBasicColor,
              onPressed: () {
                if (phisicalFeedBack) HapticFeedback.mediumImpact();
                onPressed?.call();
              },
              child: rightChild == null
                  ? child
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        child ?? const SizedBox(),
                        rightChild ?? const SizedBox(),
                      ],
                    ),
            ),
    );
  }

  ButtonStyle buttonOutLineStyle(context) => ButtonStyle(
        textStyle: MaterialStateProperty.all(
          appTheme.textTheme.bodySemibold16,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: onPressed == null ? appTheme.textGrayColor.withOpacity(0.3) : appTheme.textGrayColor,
          ),
        ),
        enableFeedback: false,
        overlayColor: MaterialStateProperty.all(appTheme.grayColor.withOpacity(0.2)),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(
          onPressed == null ? appTheme.alwaysBlackColor.withOpacity(0.4) : appTheme.alwaysBlackColor,
        ),
      );

  get getShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      );
}
