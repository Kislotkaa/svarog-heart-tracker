import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_animation_appbar.dart';
import 'package:svarog_heart_tracker/app/widgets/base_backgroudappbar.dart';
import 'package:svarog_heart_tracker/app/widgets/base_loading.dart';
import 'package:svarog_heart_tracker/app/widgets/base_status_bluetooth.dart';

import '../../../widgets/base_card_people.dart';
import '../../../widgets/base_grid_people.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double topHeight = 68;
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/icons/backGroundLogo.png',
          )).paddingAll(Get.width * 0.1),
          BaseBackgroundAddBar(height: topHeight),
          SafeArea(
            child: Stack(
              children: [
                Obx(
                  () => BaseGridPeople(
                    list: controller.list.value,
                    onRemove: (device) {
                      controller.removeDevice(device);
                    },
                    capCard: BaseCapCardPeople(
                      onTap: () {
                        controller.goToNewDevice();
                      },
                    ),
                  ),
                ).paddingOnly(top: topHeight),
                BaseAppBar(
                  height: topHeight,
                  leftChild: GestureDetector(
                    onTap: () => controller.goToAbout(),
                    child: Hero(
                      tag: 'appIcon.svg',
                      child: SvgPicture.asset(
                        'assets/images/appIcon.svg',
                        height: 36,
                      ),
                    ),
                  ),
                  rightChild: SizedBox.square(
                    dimension: 36,
                    child: BaseStatusBluetooth(
                      bluetoothController: controller.bluetoothController,
                      homeController: controller,
                    ),
                  ),
                  title: 'Сварог',
                  titleAlight: TextAlign.start,
                ),
              ],
            ),
          ),
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
