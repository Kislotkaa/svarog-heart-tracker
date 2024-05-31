import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/utils/time_format.dart';

class BaseActiveStatsHeartTimeWidget extends StatelessWidget {
  const BaseActiveStatsHeartTimeWidget({
    super.key,
    required this.secondsRed,
    required this.secondsOrange,
    required this.secondsGreen,
  });

  final int secondsRed;
  final int secondsOrange;
  final int secondsGreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FittedBox(
              child: Icon(
                Icons.favorite,
                color: appTheme.errorColor,
                size: 24,
              ),
            ),
            AutoSizeText.rich(
              TextSpan(
                text: getMin(secondsRed),
                style: appTheme.textTheme.smallButtonExtrabold12,
                children: <TextSpan>[
                  TextSpan(
                    text: ' мин',
                    style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
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
            FittedBox(
              child: Icon(
                Icons.favorite,
                color: appTheme.yellowColor,
                size: 24,
              ),
            ),
            AutoSizeText.rich(
              TextSpan(
                text: getMin(secondsOrange),
                style: appTheme.textTheme.smallButtonExtrabold12,
                children: <TextSpan>[
                  TextSpan(
                    text: ' мин',
                    style: appTheme.textTheme.smallCaptionSemibold12.copyWith(
                      color: appTheme.textGrayColor,
                    ),
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
            FittedBox(
              child: Icon(
                Icons.favorite,
                color: appTheme.greenColor,
                size: 24,
              ),
            ),
            AutoSizeText.rich(
              TextSpan(
                text: getMin(secondsGreen),
                style: appTheme.textTheme.smallButtonExtrabold12,
                children: <TextSpan>[
                  TextSpan(
                    text: ' мин',
                    style: appTheme.textTheme.smallCaptionSemibold12.copyWith(
                      color: appTheme.textGrayColor,
                    ),
                  ),
                ],
              ),
              minFontSize: 10,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}
