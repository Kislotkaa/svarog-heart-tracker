import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_duration.dart';

class BaseChecker extends StatelessWidget {
  final bool isActive;
  const BaseChecker({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeboxHW = 24;
    RxDouble sizeBorderActive = RxDouble(7);
    RxDouble sizeBorderDeActive = RxDouble(2);

    return isActive
        ? SizedBox(
            height: sizeboxHW,
            width: sizeboxHW,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isActive
                      ? AppColors.primaryConst
                      : Theme.of(context).backgroundColor,
                  width: isActive
                      ? sizeBorderActive.value
                      : sizeBorderDeActive.value,
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
                  color: isActive
                      ? AppColors.primaryConst
                      : AppColors.darkGrayColorLight,
                  width: isActive
                      ? sizeBorderActive.value
                      : sizeBorderDeActive.value,
                  style: BorderStyle.solid,
                ),
              ),
              duration: AppDuration.fast,
            ),
          );
  }
}
