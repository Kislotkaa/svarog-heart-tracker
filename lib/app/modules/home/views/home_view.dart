import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button_text.dart';
import 'package:svarog_heart_tracker/app/widgets/base_checker.dart';
import 'package:svarog_heart_tracker/app/widgets/base_loading.dart';

import '../../../widgets/base_status_bluetooth.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Stack(children: [
              Obx(
                () => Center(
                  child: ListView.builder(
                    itemCount: controller.bluetoothController.scanResult.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () => controller.bluetoothController
                            .connectOrDisconnect(
                                controller.bluetoothController.scanResult[i]),
                        child: Obx(
                          () => ListTile(
                            title: Text(controller
                                .bluetoothController.scanResult[i].device.name),
                            subtitle: const Text(
                              ' уд/м',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: BaseChecker(
                              isActive: controller.bluetoothController
                                  .haveConnectDevice(controller
                                      .bluetoothController.scanResult[i]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ).paddingAll(16),
          Align(
            alignment: Alignment.bottomCenter,
            child: controller.isLoadingLinier.value
                ? const BaseLinearLoading()
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
