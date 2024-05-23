import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_button_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_text_field_widget.dart';

Future<void> showEditDialog({
  required BuildContext context,
  required String title,
  String? initValue,
  TextInputType? type,
  TextCapitalization? textCapitalization,
  required void Function(String value) onTapConfirm,
  required String textConfirm,
}) =>
    router.push(
      EditDialogRoute(
        title: title,
        textCapitalization: textCapitalization,
        type: type,
        onTapConfirm: onTapConfirm,
        textConfirm: textConfirm,
        initValue: initValue,
      ),
    );

@RoutePage()
class EditDialogPage extends StatelessWidget {
  final String title;
  final String? initValue;
  final TextCapitalization? textCapitalization;
  final TextInputType? type;

  final void Function(String value) onTapConfirm;
  final String textConfirm;

  const EditDialogPage({
    required this.title,
    required this.initValue,
    required this.onTapConfirm,
    required this.textConfirm,
    this.textCapitalization,
    this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: initValue);
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
                    padding: const EdgeInsets.only(top: 32),
                    child: BaseTextFieldWidget(
                      textAlign: TextAlign.center,
                      type: type,
                      controller: controller,
                      hintText: 'Введите...',
                      titleCenter: true,
                      autofocus: true,
                      maxLines: 1,
                      textCapitalization: textCapitalization,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BaseButtonWidget(
                onPressed: () => onTapConfirm(controller.text),
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
