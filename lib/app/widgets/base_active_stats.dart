import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/device_controller.dart';
import '../helper/date_format.dart';
import '../helper/screan_helper.dart';
import '../helper/time_format.dart';
import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';
import 'base_graphics.dart';
import 'base_title.dart';

class BaseActiveStats extends StatefulWidget {
  BaseActiveStats({
    super.key,
    required this.device,
    required this.isLoading,
  });

  final DeviceController? device;
  final bool isLoading;

  @override
  State<BaseActiveStats> createState() => _BaseActiveStatsState();
}

class _BaseActiveStatsState extends State<BaseActiveStats>
    with TickerProviderStateMixin {
  late AnimationController animController;
  final Tween<double> tween = Tween(begin: 0.65, end: 0.85);

  @override
  void initState() {
    super.initState();

    animController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconHeart = const SizedBox();
    Widget iconHeartDifference = const SizedBox();

    if (widget.device != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BaseTitle(
            title: 'Текущая активность',
          ),
          const SizedBox(height: 12),
          _buildTimeDuration(context),
          Container(
            padding:
                const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 16),
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConst.borderRadius),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isMob()
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      _buildAnimationHeart(iconHeart, iconHeartDifference),
                      Container(
                        height: 85,
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ).paddingSymmetric(horizontal: 12),
                      _buildDetailHeartList(context).paddingOnly(right: 16),
                      _buildDetailHeartTime(context),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: 3,
                  child: BaseGraphics(
                    getHistory: () => widget.device!.getHistory(),
                    listHeartRate: widget.device!.listHeartRate,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Obx _buildDetailHeartTime(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FittedBox(
                child: Icon(
                  Icons.favorite,
                  color: AppColors.redConst,
                  size: 24,
                ),
              ),
              AutoSizeText.rich(
                TextSpan(
                  text: getMin(
                    widget.device!.secondsRed.value,
                  ),
                  style: Theme.of(context).textTheme.headline5,
                  children: <TextSpan>[
                    TextSpan(
                      text: ' мин',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                minFontSize: 10,
                maxLines: 1,
              ),
            ],
          ),
          Row(
            children: [
              const FittedBox(
                child: Icon(
                  Icons.favorite,
                  color: AppColors.orangeConst,
                  size: 24,
                ),
              ),
              AutoSizeText.rich(
                TextSpan(
                  text: getMin(
                    widget.device!.secondsOrange.value,
                  ),
                  style: Theme.of(context).textTheme.headline5,
                  children: <TextSpan>[
                    TextSpan(
                      text: ' мин',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                minFontSize: 10,
                maxLines: 1,
              ),
            ],
          ),
          Row(
            children: [
              const FittedBox(
                child: Icon(
                  Icons.favorite,
                  color: AppColors.greenConst,
                  size: 24,
                ),
              ),
              AutoSizeText.rich(
                TextSpan(
                  text: getMin(
                    widget.device!.secondsGreen.value,
                  ),
                  style: Theme.of(context).textTheme.headline5,
                  children: <TextSpan>[
                    TextSpan(
                      text: ' мин',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                minFontSize: 10,
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Obx _buildDetailHeartList(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText.rich(
            TextSpan(
              text: 'max: ',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                  text: widget.device!.maxHeart.value.toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextSpan(
                  text: ' уд/м',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            minFontSize: 10,
            maxLines: 1,
          ),
          AutoSizeText.rich(
            TextSpan(
              text: 'min: ',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                  text: widget.device!.minHeart.value.toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextSpan(
                  text: ' уд/м',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            minFontSize: 10,
            maxLines: 1,
          ),
          AutoSizeText.rich(
            TextSpan(
              text: 'avg: ',
              style: Theme.of(context).textTheme.bodyText1,
              children: <TextSpan>[
                TextSpan(
                  text: widget.device!.avgHeart.value.toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                TextSpan(
                  text: ' уд/м',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            minFontSize: 10,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Column _buildAnimationHeart(Widget iconHeart, Widget iconHeartDifference) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
          child: FittedBox(
            child: ScaleTransition(
              scale: tween.animate(
                CurvedAnimation(
                  parent: animController,
                  curve: Curves.elasticOut,
                ),
              ),
              child: StreamBuilder(
                stream: widget.device!.realHeart.stream,
                builder: (context, snapshot) {
                  if (widget.device!.realHeart.value == 0) {
                    iconHeart = Icon(
                      Icons.favorite,
                      color: Theme.of(context).dividerColor,
                      size: 62,
                    );
                  } else if (widget.device!.realHeart.value < 145) {
                    iconHeart = const Icon(
                      Icons.favorite,
                      color: AppColors.greenConst,
                      size: 62,
                    );
                  } else if (widget.device!.realHeart.value < 160) {
                    iconHeart = const Icon(
                      Icons.favorite,
                      color: AppColors.orangeConst,
                      size: 62,
                    );
                  } else {
                    iconHeart = const Icon(
                      Icons.favorite,
                      color: AppColors.redConst,
                      size: 62,
                    );
                  }
                  return iconHeart;
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: widget.device!.heartDifference.stream,
                builder: (context, snapshot) {
                  if (widget.device!.heartDifference.value < -2) {
                    iconHeartDifference = const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.greenConst,
                      size: 24,
                    );
                  } else if (widget.device!.heartDifference.value > 2) {
                    iconHeartDifference = const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AppColors.redConst,
                      size: 24,
                    );
                  } else {
                    iconHeartDifference = Icon(
                      Icons.horizontal_rule_rounded,
                      color: Theme.of(context).dividerColor,
                      size: 24,
                    );
                  }
                  return iconHeartDifference;
                },
              ),
              StreamBuilder(
                stream: widget.device!.realHeart.stream,
                builder: (context, snapshot) {
                  return AutoSizeText.rich(
                    TextSpan(
                      text: widget.device!.realHeart.value.toString(),
                      style: Theme.of(context).textTheme.headline5,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' уд/м',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    minFontSize: 10,
                    maxLines: 1,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildTimeDuration(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Obx(
            () => Text(
              dateFormatDurationSeconds(widget.device?.seconds.value) ?? '',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(right: 6, bottom: 4),
          ),
        ),
      ],
    );
  }

  bool isMob() {
    if (isMobile) {
      return true;
    } else {
      return false;
    }
  }
}
