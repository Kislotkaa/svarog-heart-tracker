import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/core/utils/screen_size.dart';
import 'package:svarog_heart_tracker/core/service/bluetooth/app_bluetooth_service.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/widgets/base_card_people.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';
import 'package:svarog_heart_tracker/locator.dart';

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
                onTap: () async {
                  final isSupported = await sl<AppBluetoothService>().isSupported;
                  if (!isSupported) {
                    AppSnackbar.showTextFloatingSnackBar(
                      title: 'Устройство не поддерживается',
                      description: 'Ваше устройство не поддерживает технологию Bluetooth',
                      overlayState: Overlay.of(context),
                    );
                  }
                  router.push(const NewDevicesRoute());
                },
              );
            }
            return GestureDetector(
              onLongPress: () => onRemove(list[i]),
              onTap: () => router.push(HistoryDetailRoute(userId: list[i].id, deviceController: list[i])),
              child: BaseCardPeople(
                deviceController: list[i],
              ),
            );
          } else {
            return BaseCapCardPeople(
              onTap: () async {
                final isSupported = await sl<AppBluetoothService>().isSupported;
                if (!isSupported) {
                  AppSnackbar.showTextFloatingSnackBar(
                    title: 'Устройство не поддерживается',
                    description: 'Ваше устройство не поддерживает технологию Bluetooth',
                    overlayState: Overlay.of(context),
                  );
                }
                router.push(const NewDevicesRoute());
              },
            );
          }
        },
      ),
    );
  }
}
