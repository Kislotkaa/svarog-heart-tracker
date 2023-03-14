import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_loading.dart';

import '../controllers/init_controller.dart';

class InitView extends GetView<InitController> {
  const InitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BaseCircularLoading(),
            const SizedBox(height: 16),
            Text(
              controller.statusLoading.value,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
