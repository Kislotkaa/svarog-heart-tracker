import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/utils/date_format.dart';
import 'package:svarog_heart_tracker/core/utils/screen_size.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/widgets/base_active_stats_heart_time_widget.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/widgets/base_graphics_widget.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

class BaseActiveStatsWidget extends StatefulWidget {
  const BaseActiveStatsWidget({
    super.key,
    required this.deviceController,
  });

  final DeviceController? deviceController;

  @override
  State<BaseActiveStatsWidget> createState() => _BaseActiveStatsWidgetState();
}

class _BaseActiveStatsWidgetState extends State<BaseActiveStatsWidget> with TickerProviderStateMixin {
  late AnimationController animController;
  final Tween<double> tween = Tween(begin: 0.65, end: 0.85);

  @override
  void initState() {
    super.initState();

    animController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceController = widget.deviceController;
    if (deviceController == null) {
      return const SizedBox();
    }

    return StreamBuilder<dynamic>(
        stream: deviceController.stream,
        builder: (context, snapshot) {
          Widget iconHeart = const SizedBox();
          Widget iconHeartDifference = const SizedBox();

          if (deviceController.realHeart == 0) {
            iconHeart = Icon(
              Icons.favorite,
              color: Theme.of(context).dividerColor,
              size: 62,
            );
          } else if (deviceController.realHeart < 145) {
            iconHeart = Icon(
              Icons.favorite,
              color: appTheme.greenColor,
              size: 62,
            );
          } else if (deviceController.realHeart < 160) {
            iconHeart = Icon(
              Icons.favorite,
              color: appTheme.yellowColor,
              size: 62,
            );
          } else {
            iconHeart = Icon(
              Icons.favorite,
              color: appTheme.errorColor,
              size: 62,
            );
          }

          if (deviceController.heartDifference < -2) {
            iconHeartDifference = Icon(
              Icons.keyboard_arrow_down_rounded,
              color: appTheme.greenColor,
              size: 24,
            );
          } else if (deviceController.heartDifference > 2) {
            iconHeartDifference = Icon(
              Icons.keyboard_arrow_up_rounded,
              color: appTheme.errorColor,
              size: 24,
            );
          } else {
            iconHeartDifference = Icon(
              Icons.horizontal_rule_rounded,
              color: appTheme.textGrayColor,
              size: 24,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Текущая активность',
                style: appTheme.textTheme.subheaderExtrabold18,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6, bottom: 4),
                      child: Text(
                        dateFormatDurationSeconds(deviceController.seconds) ?? '',
                        textAlign: TextAlign.end,
                        style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 16),
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                            ScreenSize.isMobile(context) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 1,
                                child: FittedBox(
                                  child: ScaleTransition(
                                    scale: tween.animate(
                                      CurvedAnimation(
                                        parent: animController,
                                        curve: Curves.elasticOut,
                                      ),
                                    ),
                                    child: iconHeart,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    iconHeartDifference,
                                    AutoSizeText.rich(
                                      TextSpan(
                                        text: deviceController.realHeart.toString(),
                                        style: appTheme.textTheme.smallButtonExtrabold12,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' уд/м',
                                            style: appTheme.textTheme.smallCaptionSemibold12
                                                .copyWith(color: appTheme.textGrayColor),
                                          ),
                                        ],
                                      ),
                                      minFontSize: 10,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            color: appTheme.grayColor,
                            width: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'max: ',
                                  style: appTheme.textTheme.smallCaptionSemibold12,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: deviceController.maxHeart.toString(),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                    ),
                                    TextSpan(
                                      text: ' уд/м',
                                      style: appTheme.textTheme.smallCaptionSemibold12
                                          .copyWith(color: appTheme.textGrayColor),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'min: ',
                                  style: appTheme.textTheme.smallCaptionSemibold12,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: deviceController.minHeart.toString(),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                    ),
                                    TextSpan(
                                      text: ' уд/м',
                                      style: appTheme.textTheme.smallCaptionSemibold12
                                          .copyWith(color: appTheme.textGrayColor),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'avg: ',
                                  style: appTheme.textTheme.smallCaptionSemibold12,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: deviceController.avgHeart.toString(),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                    ),
                                    TextSpan(
                                      text: ' уд/м',
                                      style: appTheme.textTheme.smallCaptionSemibold12
                                          .copyWith(color: appTheme.textGrayColor),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            color: appTheme.grayColor,
                            width: 1,
                          ),
                          BaseActiveStatsHeartTimeWidget(
                            secondsRed: deviceController.secondsRed,
                            secondsOrange: deviceController.secondsOrange,
                            secondsGreen: deviceController.secondsGreen,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 3,
                      child: BaseGraphicsWidget(
                        listHeartRate: deviceController.listHeartRate,
                        deviceController: deviceController,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
