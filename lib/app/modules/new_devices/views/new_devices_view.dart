import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_checker.dart';
import 'package:svarog_heart_tracker/app/widgets/base_divider.dart';
import 'package:svarog_heart_tracker/app/widgets/base_handler.dart';

import '../../../resourse/app_const.dart';
import '../../../resourse/base_icons_icons.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/base_cap.dart';
import '../../../widgets/base_loading.dart';
import '../controllers/new_devices_controller.dart';

Future<void> showNewDevices() async {
  await showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    constraints: BoxConstraints.expand(height: Get.height * 0.85),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConst.borderRadius),
      ),
    ),
    builder: (context) => GetBuilder(
      init: NewDevicesController(
        bluetoothController: Get.find(),
        homeController: Get.find(),
        permissionController: Get.find(),
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
                  BaseHandle(
                    color: Theme.of(context).canvasColor,
                  ),
                  Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.textStatus.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.scanDevices(),
                          child: Icon(
                            Icons.refresh_rounded,
                          ),
                        )
                      ],
                    ),
                  ),
                  const BaseDivider().paddingSymmetric(
                    horizontal: AppConst.paddingAll,
                  ),
                  Obx(
                    () => controller.scanResult.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: controller.scanResult.length,
                              padding: const EdgeInsets.only(
                                left: AppConst.paddingAll,
                                right: AppConst.paddingAll,
                                top: AppConst.paddingAll,
                                bottom: 100,
                              ),
                              itemBuilder: (context, i) {
                                return InkWell(
                                    onTap: () => controller.connectOrDisconnect(
                                          controller.scanResult[i].blueDevice,
                                        ),
                                    child: Row(
                                      children: [
                                        BaseChecker(
                                          isActive: controller.haveConnect(
                                            controller.scanResult[i].blueDevice,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller
                                                  .scanResult[i].deviceName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              controller
                                                  .scanResult[i].deviceNumber,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )
                                          ],
                                        )
                                      ],
                                    ).paddingOnly(bottom: 16));
                              },
                            ),
                          )
                        : BaseCapScreen(
                            title: 'Список доступных устройст пуст.',
                            caption: 'Как подключить устройство?',
                            textLink: 'Жмак!',
                            icon: BaseIcons.hide,
                            onRefresh: () {
                              controller.scanDevices();
                            },
                            onTap: () async {
                              await Get.toNamed(Routes.HOW_TO_USE)
                                  ?.then((value) => controller.scanDevices());
                            },
                          ),
                  ),
                ],
              ),
            ),
            controller.isLoadingLinier.value
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: BaseLinearLoading(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
