import 'package:flutter/material.dart';

import '../resourse/app_colors.dart';

class BaseCircularLoading extends StatelessWidget {
  const BaseCircularLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryActiveConst,
      ),
    );
  }
}

class BaseLinearLoading extends StatelessWidget {
  const BaseLinearLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      color: AppColors.primaryActiveConst,
    );
  }
}
