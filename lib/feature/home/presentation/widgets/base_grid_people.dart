import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/utils/screen_size.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/widgets/base_card_people.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

class BaseGridPeople extends StatelessWidget {
  const BaseGridPeople({
    super.key,
    required this.list,
    required this.onRemove,
    this.onRefresh,
  });
  final Function(DeviceController device) onRemove;
  final void Function()? onRefresh;

  final List<DeviceController> list;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh?.call(),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ScreenSize.isMobile(context) ? 2 : 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: MediaQuery.of(context).size.width * 0.3,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        itemCount: list.isEmpty ? 1 : list.length + 1,
        itemBuilder: (BuildContext context, int i) {
          if (list.isNotEmpty) {
            if (i == list.length) {
              return BaseCapCardPeople(
                onTap: () {
                  router.push(const NewDevicesRoute());
                },
              );
            }
            return GestureDetector(
              onLongPress: () => onRemove(list[i]),
              onTap: () => router.push(const HistoryDetailRoute()),
              child: BaseCardPeople(
                name: list[i].name,
                heartRate: list[i].realHeart,
                heartRateDifference: list[i].heartDifference,
              ),
            );
          } else {
            return BaseCapCardPeople(
              onTap: () {
                router.push(const NewDevicesRoute());
              },
            );
          }
        },
      ),
    );
  }
}
