import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_button.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_button_text.dart';
import 'package:svarog_heart_tracker/core/utils/base_dialog.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String text,
  Function()? onTapConfirm,
  Function()? onTapCancel,
  String? textConfirm,
  String? textCancel,
}) =>
    baseDialog(
      context: context,
      child: ConfirmDialogWidget(
        title: title,
        description: text,
        onTapConfirm: () {},
        onTapCancel: () {},
        textConfirm: '',
        textCancel: '',
      ),
    );

class ConfirmDialogWidget extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onTapConfirm;
  final Function()? onTapCancel;
  final String? textConfirm;
  final String? textCancel;

  const ConfirmDialogWidget({
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
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: appTheme.cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: Text(
                      title,
                      style: appTheme.textTheme.buttonExtrabold16,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: Text(
                      description,
                      style: appTheme.textTheme.buttonExtrabold16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            BaseButton(
              onPressed: onTapCancel,
              child: BaseButtonText(
                textCancel ?? 'textCancel',
              ),
            ),
            const SizedBox(height: 8),
            BaseButton(
              onPressed: onTapConfirm,
              child: BaseButtonText(
                textConfirm ?? 'textConfirm',
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
