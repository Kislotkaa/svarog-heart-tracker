import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';
import 'package:svarog_heart_tracker/locator.dart';

class BaseCardPeople extends StatefulWidget {
  const BaseCardPeople({
    super.key,
    required this.deviceController,
  });

  final DeviceController deviceController;

  @override
  State<BaseCardPeople> createState() => _BaseCardPeopleState();
}

class _BaseCardPeopleState extends State<BaseCardPeople> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 0.65, end: 0.85);
  final appSettings = sl<GlobalSettingsService>().appSettings;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(appSettings.greenZone);
    print(appSettings.orangeZone);
    return StreamBuilder<dynamic>(
        stream: widget.deviceController.stream,
        builder: (context, snapshot) {
          Widget iconHeart = const SizedBox();
          Widget iconHeartDifference = const SizedBox();

          if (widget.deviceController.realHeart == 0) {
            iconHeart = Icon(
              Icons.favorite,
              color: appTheme.grayColor,
              size: 62,
            );
          } else if (widget.deviceController.realHeart < appSettings.greenZone) {
            iconHeart = Icon(
              Icons.favorite,
              color: appTheme.greenColor,
              size: 62,
            );
          } else if (widget.deviceController.realHeart < appSettings.orangeZone) {
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
          if (widget.deviceController.heartDifference < -2) {
            iconHeartDifference = Icon(
              Icons.keyboard_arrow_down_rounded,
              color: appTheme.greenColor,
            );
          } else if (widget.deviceController.heartDifference > 2) {
            iconHeartDifference = Icon(
              Icons.keyboard_arrow_up_rounded,
              color: appTheme.errorColor,
            );
          } else {
            iconHeartDifference = Icon(
              Icons.horizontal_rule_rounded,
              color: appTheme.grayColor,
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: appTheme.cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: appTheme.grayColor,
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: AutoSizeText(
                    widget.deviceController.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: appTheme.textTheme.subheaderExtrabold18,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FittedBox(
                    child: ScaleTransition(
                      scale: _tween.animate(
                        CurvedAnimation(
                          parent: _controller,
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
                          text: widget.deviceController.realHeart.toString(),
                          style: appTheme.textTheme.smallButtonExtrabold12,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' уд/м',
                              style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
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
          );
        });
  }
}

class BaseCapCardPeople extends StatelessWidget {
  const BaseCapCardPeople({
    super.key,
    this.onTap,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: appTheme.cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: appTheme.grayColor,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 28,
          ),
        ),
      ),
    );
  }
}
