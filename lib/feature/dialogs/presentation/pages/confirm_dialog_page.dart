import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_button_widget.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String description,
  required Function() onTapConfirm,
  required Function() onTapCancel,
  required String textConfirm,
  required String textCancel,
}) =>
    router.push(
      ConfirmDialogRoute(
          title: title,
          description: description,
          onTapConfirm: onTapConfirm,
          onTapCancel: onTapCancel,
          textConfirm: textConfirm,
          textCancel: textCancel),
    );

@RoutePage()
class ConfirmDialogPage extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onTapConfirm;
  final Function()? onTapCancel;
  final String textConfirm;
  final String textCancel;

  const ConfirmDialogPage({
    required this.title,
    required this.description,
    required this.onTapConfirm,
    required this.onTapCancel,
    required this.textConfirm,
    required this.textCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          color: appTheme.cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: appTheme.textTheme.buttonExtrabold16,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      description,
                      style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.textGrayColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BaseButtonWidget(
                onPressed: onTapCancel,
                isOutLine: true,
                child: Text(
                  textCancel,
                  style: appTheme.textTheme.bodySemibold16,
                ),
              ),
              const SizedBox(height: 16),
              BaseButtonWidget(
                onPressed: onTapConfirm,
                child: Text(
                  textConfirm,
                  style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.revertTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
