import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/device_controller.dart';

import '../helper/screan_helper.dart';
import '../resourse/app_const.dart';
import 'base_card_people.dart';

class BaseGridPeople extends StatelessWidget {
  const BaseGridPeople({
    super.key,
    required this.capCard,
    required this.list,
    required this.onRemove,
    required this.onRefresh,
    required this.goToDetailHistory,
  });
  final Widget capCard;
  final Function(DeviceController device) onRemove;
  final Future<void> Function(String id) goToDetailHistory;
  final Future<void> Function() onRefresh;

  final List<DeviceController> list;

  @override
  Widget build(BuildContext context) {
    int countItem = getItemCountGrid();

    return RefreshIndicator(
      onRefresh: () async => await onRefresh(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: countItem,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: Get.width * 0.3,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConst.paddingAll,
          vertical: 24,
        ),
        itemCount: list.isEmpty ? 1 : list.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (list.isNotEmpty) {
            if (index == list.length) {
              return capCard;
            }
            return _buildItem(index);
          } else {
            return capCard;
          }
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    return Obx(
      () => GestureDetector(
        onLongPress: () => onRemove(list[index]),
        onTap: () => goToDetailHistory(list[index].id),
        child: BaseCardPeople(
          name: list[index].name,
          heartRate: list[index].realHeart.value,
          heartRateDifference: list[index].heartDifference.value,
        ),
      ),
    );
  }

  int getItemCountGrid() {
    if (isMobile) {
      return 2;
    } else if (isTable) {
      return 3;
    } else {
      return 1;
    }
  }
}
