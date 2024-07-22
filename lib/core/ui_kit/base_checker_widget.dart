import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/theme/utils/duration.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';

class BaseCheckerWidget extends StatefulWidget {
  final bool isActive;
  const BaseCheckerWidget({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  State<BaseCheckerWidget> createState() => _BaseCheckerWidgetState();
}

class _BaseCheckerWidgetState extends State<BaseCheckerWidget> {
  @override
  Widget build(BuildContext context) {
    double sizeboxHW = 24;
    double sizeBorderActive = 5.0;
    double sizeBorderDeActive = 2.0;

    return SizedBox(
      height: sizeboxHW,
      width: sizeboxHW,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: widget.isActive ? appTheme.textColor : appTheme.textColor,
            width: widget.isActive ? sizeBorderActive : sizeBorderDeActive,
            style: BorderStyle.solid,
          ),
        ),
        duration: AppDuration.fast,
      ),
    );
  }
}
