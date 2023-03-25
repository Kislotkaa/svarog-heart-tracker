import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';

class BaseCardPeople extends StatefulWidget {
  const BaseCardPeople({
    super.key,
    required this.name,
    required this.heartRate,
    required this.heartRateDifference,
  });

  final String name;
  final int heartRate;
  final int heartRateDifference;

  @override
  State<BaseCardPeople> createState() => _BaseCardPeopleState();
}

class _BaseCardPeopleState extends State<BaseCardPeople>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 0.65, end: 0.85);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconHeart = SizedBox();
    Widget iconHeartDifference = SizedBox();

    if (widget.heartRate == 0) {
      iconHeart = Icon(
        Icons.favorite,
        color: Theme.of(context).dividerColor,
        size: 62,
      );
    } else if (widget.heartRate < 145) {
      iconHeart = const Icon(
        Icons.favorite,
        color: AppColors.greenConst,
        size: 62,
      );
    } else if (widget.heartRate < 160) {
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
    if (widget.heartRateDifference < -2) {
      iconHeartDifference = const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.greenConst,
      );
    } else if (widget.heartRateDifference > 2) {
      iconHeartDifference = const Icon(
        Icons.keyboard_arrow_up_rounded,
        color: AppColors.redConst,
      );
    } else {
      iconHeartDifference = Icon(
        Icons.horizontal_rule_rounded,
        color: Theme.of(context).dividerColor,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).canvasColor,
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
              widget.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
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
                    text: widget.heartRate.toString(),
                    style: Theme.of(context).textTheme.headline3,
                    children: <TextSpan>[
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
          ),
        ],
      ),
    );
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
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).canvasColor,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
