import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/models/user_model.dart';
import 'package:svarog_heart_tracker/app/widgets/base_loading.dart';
import 'package:svarog_heart_tracker/app/widgets/base_title.dart';

import '../../../resourse/app_const.dart';
import '../../../resourse/base_icons_icons.dart';
import '../../../widgets/base_animation_appbar.dart';
import '../../../widgets/base_backgroudappbar.dart';
import '../../../widgets/base_cap.dart';
import '../../../widgets/base_history_user.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
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
                Obx(
                  () => controller.users.isNotEmpty
                      ? BaseListHistory(
                          height: height,
                          goToDetailHistory: (String? id) =>
                              controller.goToDetailHistory(id),
                          isConnected: (String? id) =>
                              controller.isConnected(id),
                          onDeleteUser: (String? id) async =>
                              await controller.onDeleteUser(id),
                          users: controller.users.value,
                          onRefresh: () async => await controller.getHistory(),
                        )
                      : Column(
                          children: [
                            BaseCapScreen(
                              title: 'История отсутсвует',
                              caption:
                                  'Начните пользоваться приложением и история подключений будет пополняться',
                              icon: BaseIcons.hide,
                              onRefresh: () async {
                                await controller.getHistory();
                              },
                            ),
                          ],
                        ),
                ),
                BaseAppBar(
                  onTapBack: () => controller.goToBack(),
                  height: height,
                  titleAlight: TextAlign.start,
                  title: 'История подключений',
                  leftChild: Icon(Icons.arrow_back_ios_new_rounded),
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

class BaseListHistory extends StatelessWidget {
  const BaseListHistory({
    super.key,
    required this.height,
    required this.users,
    required this.isConnected,
    required this.onDeleteUser,
    required this.goToDetailHistory,
    required this.onRefresh,
  });

  final double height;
  final List<UserModel?> users;
  final Function(String? id) isConnected;
  final Future<bool> Function(String? id) onDeleteUser;
  final Function(String? id) goToDetailHistory;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    List<Widget> userActive = [];
    List<Widget> userUnActive = [];

    users.forEach((element) {
      if (isConnected(element?.id)) {
        if (element != null) {
          userActive.add(
            BaseHistoryUser(
              deviceName: element.deviceName,
              isConnected: true,
              personName: element.personName,
              onDelete: () async => await onDeleteUser(element.id),
              goToDetail: () => goToDetailHistory(element.id),
            ),
          );
        }
      } else {
        if (element != null) {
          userUnActive.add(
            BaseHistoryUser(
              deviceName: element.deviceName,
              isConnected: false,
              personName: element.personName,
              onDelete: () async => await onDeleteUser(element.id),
              goToDetail: () => goToDetailHistory(element.id),
            ),
          );
        }
      }
    });

    return RefreshIndicator(
      onRefresh: () async => await onRefresh(),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppConst.paddingAll,
          vertical: 16,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userActive.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseTitle(title: 'Активные'),
                        const SizedBox(height: 16),
                        Column(children: userActive),
                      ],
                    )
                  : const SizedBox(),
              userUnActive.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseTitle(title: 'Неактивные'),
                        const SizedBox(height: 16),
                        Column(children: userUnActive),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    ).paddingOnly(top: height);
  }
}
