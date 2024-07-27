import 'package:flutter/widgets.dart';
import 'package:svarog_heart_tracker/core/constant/constants.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';

class BaseZoneEditWidget extends StatelessWidget {
  const BaseZoneEditWidget({
    super.key,
    required this.greenZoneController,
    required this.orangeZoneController,
  });

  final TextEditingController greenZoneController;
  final TextEditingController orangeZoneController;

  @override
  Widget build(BuildContext context) {
    final int greenZone = int.tryParse(greenZoneController.text) ?? HeartZone.greenZone;
    final int orangeZone = int.tryParse(orangeZoneController.text) ?? HeartZone.orangeZone;

    return GestureDetector(
      onTap: () => router.push(ZoneEditRoute(
        greenZone: greenZoneController,
        orangeZone: orangeZoneController,
      )),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Text(
                    '0',
                    style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                  ),
                  const Spacer(),
                  Text(
                    '∞',
                    style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: appTheme.grayColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: greenZone,
                        child: Container(
                          color: appTheme.greenColor,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      Expanded(
                        flex: orangeZone,
                        child: Container(
                          color: appTheme.yellowColor,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      Expanded(
                        flex: ((greenZone + orangeZone) * 0.2).toInt(),
                        child: Container(
                          color: appTheme.errorColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacer(flex: greenZone),
                    Text(
                      '$greenZone',
                      style: appTheme.textTheme.captionSemibold14,
                    ),
                    Spacer(flex: orangeZone),
                    Text(
                      '$orangeZone',
                      style: appTheme.textTheme.captionSemibold14,
                    ),
                    Spacer(flex: ((greenZone + orangeZone) * 0.2).toInt()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
