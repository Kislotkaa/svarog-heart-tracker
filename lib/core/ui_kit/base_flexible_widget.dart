import 'package:flutter/widgets.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';

class FlexibleWidget extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color? color;

  const FlexibleWidget({this.borderRadius, this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: ColoredBox(
        color: color ?? appTheme.basicColor,
        child: const SizedBox.expand(),
      ),
    );
  }
}
