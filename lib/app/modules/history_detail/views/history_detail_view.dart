import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resourse/app_const.dart';
import '../../../resourse/base_icons_icons.dart';
import '../../../widgets/base_active_stats.dart';
import '../../../widgets/base_animation_appbar.dart';
import '../../../widgets/base_backgroudappbar.dart';
import '../../../widgets/base_cap.dart';
import '../../../widgets/base_history_stats.dart';
import '../../../widgets/base_loading.dart';
import '../../../widgets/base_title.dart';
import '../controllers/history_detail_controller.dart';

class HistoryDetailView extends GetView<HistoryDetailController> {
  const HistoryDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 68;

    return Scaffold(
      body: Stack(
        children: [
          BaseBackgroundAddBar(height: height),
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Obx(() => controller.listHistory.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () => controller.getDetailHistory(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConst.paddingAll,
                            horizontal: AppConst.paddingAll,
                          ),
                          itemCount: controller.listHistory.length,
                          itemBuilder: (context, i) {
                            if (i == 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BaseActiveStats(
                                    device: controller.deviceController,
                                    isLoading: controller.isLoading.value,
                                  ),
                                  const SizedBox(height: 16),
                                  const BaseTitle(
                                    title: 'История активности',
                                  ),
                                  const SizedBox(height: 12),
                                  BaseHistoryStats(
                                    history: controller.listHistory[i],
                                    onDelete: (id) =>
                                        controller.onTapDeleteHistory(id),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  BaseHistoryStats(
                                    history: controller.listHistory[i],
                                    onDelete: (id) =>
                                        controller.onTapDeleteHistory(id),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ).paddingSymmetric(vertical: height)
                    : Column(
                        children: [
                          BaseCapScreen(
                            title: 'История отсутсвует',
                            caption:
                                'Начните пользоваться приложением и история тренировок будет пополняться',
                            icon: BaseIcons.hide,
                            onRefresh: () {
                              controller.getDetailHistory();
                            },
                          ),
                        ],
                      ).paddingSymmetric(
                        horizontal: AppConst.paddingAll,
                        vertical: Get.height * 0.1,
                      )),
                Obx(
                  () => BaseAppBar(
                    onTapBack: () => controller.goToBack(),
                    height: height,
                    titleAlight: TextAlign.start,
                    title: controller.user.value?.personName ?? 'Empty',
                    leftChild: const Icon(Icons.arrow_back_ios_new_rounded),
                    rightChild: Row(
                      children: [
                        Text(
                          'Авто\nсопряжение',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Switch(
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (bool value) =>
                              controller.swithAutoConnect(),
                          value: controller.user.value?.isAutoConnect ?? false,
                        ),
                        controller.listHistory.isNotEmpty
                            ? GestureDetector(
                                onTap: () => controller.onTapDeleteAllHistory(),
                                child: Icon(BaseIcons.trash_full),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: BaseLinearLoading(),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
