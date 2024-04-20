import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/constant/duration.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

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
    double sizeBorderActive = 7.0;
    double sizeBorderDeActive = 2.0;

    return widget.isActive
        ? SizedBox(
            height: sizeboxHW,
            width: sizeboxHW,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: widget.isActive ? appTheme.primaryColor : appTheme.grayColor,
                  width: widget.isActive ? sizeBorderActive : sizeBorderDeActive,
                  style: BorderStyle.solid,
                ),
              ),
              duration: AppDuration.fast,
            ),
          )
        : SizedBox(
            height: sizeboxHW,
            width: sizeboxHW,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: widget.isActive ? appTheme.primaryColor : appTheme.grayColor,
                  width: widget.isActive ? sizeBorderActive : sizeBorderDeActive,
                  style: BorderStyle.solid,
                ),
              ),
              duration: AppDuration.fast,
            ),
          );
  }
}
