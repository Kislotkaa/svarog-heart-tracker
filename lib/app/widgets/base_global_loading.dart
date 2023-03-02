import 'package:flutter/material.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';
import '../resourse/app_shadow.dart';
import 'base_loading.dart';

class BaseGlobalLoading extends StatelessWidget {
  const BaseGlobalLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteConst.withOpacity(0),
      child: Center(
        child: Container(
          height: 100,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConst.borderRadius),
            color: Theme.of(context).cardColor,
            boxShadow: [AppShadow.shadowAccentLight],
            border: Border.all(color: Theme.of(context).backgroundColor),
          ),
          child: const BaseCircularLoading(),
        ),
      ),
    );
  }
}
