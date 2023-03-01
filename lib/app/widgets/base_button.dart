import 'package:flutter/material.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    this.child,
    this.onPressed,
    this.rightChild,
    this.height = 40,
    this.width = double.infinity,
    this.isOutLine = false,
    this.visualFeedBack = false,
  }) : super(key: key);
  final Widget? child;
  final Widget? rightChild;
  final Function? onPressed;
  final double? height;
  final bool isOutLine;
  final bool visualFeedBack;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: height,
        width: width,
        child: isOutLine
            ? OutlinedButton(
                style: buttonOutLineStyle(context),
                onPressed: onPressed as Function()?,
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
                disabledColor: Theme.of(context).primaryColor.withOpacity(0.4),
                splashColor: Theme.of(context).primaryColor,
                focusElevation: 0,
                hoverElevation: 0,
                highlightElevation: visualFeedBack ? 3 : 0,
                color: Theme.of(context).primaryColor,
                child: rightChild == null
                    ? child
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          child ?? const SizedBox(),
                          rightChild ?? const SizedBox(),
                        ],
                      ),
                onPressed: onPressed as Function()?,
              ),
      ),
    );
  }

  ButtonStyle buttonOutLineStyle(context) => ButtonStyle(
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.bodyText2,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConst.borderRadius),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: onPressed == null
                ? AppColors.primaryConst.withOpacity(0.3)
                : AppColors.primaryConst.withOpacity(0.8),
          ),
        ),
        enableFeedback: false,
        overlayColor: MaterialStateProperty.all(
            Theme.of(context).cardColor.withOpacity(0.2)),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(
          onPressed == null
              ? Theme.of(context).primaryColorDark.withOpacity(0.4)
              : Theme.of(context).primaryColorDark,
        ),
      );

  get getShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppConst.borderRadius),
        ),
      );
}
