import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_const.dart';

class BaseGridPeople extends StatelessWidget {
  const BaseGridPeople({
    super.key,
    required this.children,
  });
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: Get.width * 0.3,
      ),
      padding: const EdgeInsets.all(AppConst.paddingAll),
      children: children,
    );
  }
}
