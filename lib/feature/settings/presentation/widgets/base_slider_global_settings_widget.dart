import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/edit_dialog_page.dart';

class BaseSliderGlobalSettingsWidget extends StatelessWidget {
  const BaseSliderGlobalSettingsWidget({
    super.key,
    required this.title,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.slug,
    required this.onChanged,
  });

  final String title;
  final double? value;
  final double maxValue;
  final double minValue;
  final Function(double value)? onChanged;

  final String slug;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                showEditDialog(
                  context: context,
                  title: 'Укажите время в секундах',
                  initValue: '',
                  type: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  onTapConfirm: (value) {
                    final result = double.tryParse(value);
                    if (result == null) {
                      router.removeLast();
                      return;
                    }
                    if (result >= minValue && result <= maxValue) {
                      onChanged?.call(result);
                      router.removeLast();
                    } else {
                      AppSnackbar.showTextFloatingSnackBar(
                        title: 'Граница диапазона нарушена',
                        description: 'Число должно быть в указанной границе',
                        status: SnackStatusEnum.warning,
                        overlayState: Overlay.of(context),
                      );
                    }
                  },
                  textConfirm: 'Изменить',
                );
              },
              child: ColoredBox(
                color: Colors.transparent,
                child: Text(
                  '${value?.toInt().toString() ?? ''} $slug |',
                  style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                ),
              ),
            ),
            Expanded(
              child: Slider.adaptive(
                value: value ?? 180,
                min: minValue,
                max: maxValue,
                onChanged: (value) {
                  if (this.value != value) HapticFeedback.selectionClick();
                  onChanged?.call(value);
                },
                activeColor: appTheme.revertBasicColor,
                thumbColor: appTheme.revertBasicColor,
              ),
            ),
            Text(
              '| ${maxValue.toInt().toString()}',
              style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
