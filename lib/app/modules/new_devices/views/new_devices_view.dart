import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/models/user_model.dart';
import 'package:svarog_heart_tracker/app/widgets/base_checker.dart';
import 'package:svarog_heart_tracker/app/widgets/base_divider.dart';
import 'package:svarog_heart_tracker/app/widgets/base_handler.dart';

import '../../../models/new_device_model.dart';
import '../../../resourse/app_const.dart';
import '../../../resourse/base_icons_icons.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/base_cap.dart';
import '../../../widgets/base_new_device.dart';
import '../../../widgets/base_loading.dart';
import '../../../widgets/base_title.dart';
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
        userRepository: Get.find(),
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
                            child: BaseListNewDevice(
                              connectOrDisconnect: (BluetoothDevice device) =>
                                  controller.connectOrDisconnect(device),
                              haveConnect: (BluetoothDevice device) =>
                                  controller.haveConnect(device),
                              scanResult: controller.scanResult.value,
                              isPreviouslyConnected: (String id) =>
                                  controller.isPreviouslyConnected(id),
                              getName: (String id) =>
                                  controller.getNamePreviouslyDevice(id),
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

class BaseListNewDevice extends StatelessWidget {
  const BaseListNewDevice({
    super.key,
    required this.scanResult,
    required this.isPreviouslyConnected,
    required this.haveConnect,
    required this.getName,
    required this.connectOrDisconnect,
  });

  final List<NewDeviceModel> scanResult;
  final Function(BluetoothDevice device) haveConnect;
  final Function(String id) isPreviouslyConnected;
  final Function(String id) getName;
  final Function(BluetoothDevice device) connectOrDisconnect;

  @override
  Widget build(BuildContext context) {
    List<Widget> oldDevice = [];
    List<Widget> newDevice = [];

    scanResult.forEach((element) {
      if (isPreviouslyConnected(element.deviceId)) {
        if (element != null) {
          oldDevice.add(
            BaseNewDevice(
              connectOrDisconnect: connectOrDisconnect,
              device: element,
              haveConnect: haveConnect,
              name: getName(element.deviceId),
              number: element.deviceNumber,
            ),
          );
        }
      } else {
        if (element != null) {
          newDevice.add(
            BaseNewDevice(
              connectOrDisconnect: connectOrDisconnect,
              device: element,
              haveConnect: haveConnect,
              name: element.deviceName,
              number: element.deviceNumber,
            ),
          );
        }
      }
    });
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: scanResult.length,
      padding: const EdgeInsets.only(
        left: AppConst.paddingAll,
        right: AppConst.paddingAll,
        top: 24,
        bottom: 100,
      ),
      itemBuilder: (context, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newDevice.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseTitle(title: 'Новые'),
                      const SizedBox(height: 16),
                      Column(children: newDevice),
                    ],
                  )
                : const SizedBox(),
            oldDevice.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseTitle(title: 'Ранее подключенные'),
                      const SizedBox(height: 16),
                      Column(children: oldDevice),
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
