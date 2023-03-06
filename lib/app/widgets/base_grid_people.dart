import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/controllers/device_controller.dart';

import '../resourse/app_const.dart';
import 'base_card_people.dart';

class BaseGridPeople extends StatelessWidget {
  const BaseGridPeople({
    super.key,
    required this.capCard,
    required this.list,
    required this.onRemove,
  });
  final Widget capCard;
  final Function(DeviceController device) onRemove;
  final List<DeviceController> list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: Get.width * 0.3,
      ),
      padding: const EdgeInsets.all(AppConst.paddingAll),
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
    );
  }

  Widget _buildItem(int index) {
    return Obx(
      () => GestureDetector(
        onLongPress: () => onRemove(list[index]),
        child: BaseCardPeople(
          name: list[index].name,
          heartRate: list[index].heartAvg.value,
        ),
      ),
    );
  }
}
