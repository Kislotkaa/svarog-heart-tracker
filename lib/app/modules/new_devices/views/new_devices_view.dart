import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_divider.dart';

import '../../../resourse/app_const.dart';
import '../../../widgets/base_animation_appbar.dart';
import '../../../widgets/base_handler.dart';
import '../../../widgets/base_loading.dart';
import '../controllers/new_devices_controller.dart';

Future<void> showNewDevices() async {
  await showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    constraints: BoxConstraints.expand(height: Get.height * 0.9),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConst.borderRadius),
      ),
    ),
    builder: (context) => GetBuilder(
      init: NewDevicesController(
        bluetoothController: Get.find(),
      ),
      builder: (dynamic _) => const NewDevicesView(),
    ),
  );
}

class NewDevicesView extends GetView<NewDevicesController> {
  const NewDevicesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(
          AppConst.paddingAll,
        ),
      ),
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Obx(() => BaseAppBar(
                        backgroundColor: false,
                        boxShadow: [],
                        onTapBack: () => Get.back(),
                        height: 55,
                        title: controller.textStatus.value,
                        titleAlight: TextAlign.start,
                      )),
                  const BaseDivider()
                      .paddingSymmetric(horizontal: AppConst.paddingAll),
                ],
              ),
            ),
            controller.isLoadingLinier.value
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: BaseLinearLoading(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
