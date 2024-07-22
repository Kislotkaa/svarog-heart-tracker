import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/common/assets.gen.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/models/user_history_model.dart';
import 'package:svarog_heart_tracker/core/utils/date_format.dart';

class BaseHistoryStatsWidget extends StatelessWidget {
  const BaseHistoryStatsWidget({
    super.key,
    required this.needFullProfile,
    required this.history,
    required this.onDelete,
  });

  final bool needFullProfile;
  final UserHistoryModel history;
  final Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    List<FlSpot> listSpot = [];
    for (var i = 0; i < history.yHeart.length; i++) {
      listSpot.add(FlSpot(i.toDouble(), history.yHeart[i].toDouble()));
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: ValueKey<String>(history.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          onDelete(history.id);
          return true;
        },
        secondaryBackground: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline_rounded,
            color: appTheme.alwaysWhiteColor,
          ),
        ),
        background: const SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, bottom: 4),
                    child: Text(
                      dateFormatDefault(history.createAt ?? DateTime.now()),
                      style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6, bottom: 4),
                    child: Text(
                      dateFormatDuration(
                            history.createAt,
                            history.finishedAt,
                          ) ??
                          '',
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
              decoration: BoxDecoration(
                color: appTheme.cardColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 105,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AutoSizeText.rich(
                                TextSpan(
                                  text: 'max: ',
                                  style: appTheme.textTheme.smallCaptionSemibold12,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: history.maxHeart.toString(),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                    ),
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
                              AutoSizeText.rich(
                                TextSpan(
                                  text: 'min: ',
                                  style: appTheme.textTheme.smallCaptionSemibold12,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: history.minHeart.toString(),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                    ),
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
                              AutoSizeText.rich(
                                TextSpan(
                                  text: 'avg: ',
                                  style: appTheme.textTheme.smallCaptionSemibold12,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: history.avgHeart.toString(),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                    ),
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
                      ),
                      SizedBox(
                        height: 105,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
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
                                      text: getMin(history.redTimeHeart),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' мин',
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
                                      text: getMin(history.orangeTimeHeart),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' мин',
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
                                      text: getMin(history.greenTimeHeart),
                                      style: appTheme.textTheme.smallButtonExtrabold12,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' мин',
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
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 105,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: false,
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    getTitlesWidget: leftTitleWidgets,
                                    showTitles: false,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              minY: history.yHeart.min.toDouble() - history.yHeart.min / 2,
                              maxY: history.yHeart.max.toDouble() + history.yHeart.max / 2,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: listSpot,
                                  isCurved: true,
                                  color: appTheme.errorColor,
                                  barWidth: 1,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(
                                    show: false,
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        appTheme.errorColor,
                                        appTheme.cardColor,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Builder(builder: (context) {
                    if (history.calories == null && needFullProfile == false) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.icons.fire.svg(height: 20, width: 20),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                needFullProfile
                                    ? 'Заполните профиль спорстмена для расчёта калорий'
                                    : '${history.calories?.toInt()} ккал',
                                style: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.textGrayColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      value.toString(),
      style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
      textAlign: TextAlign.right,
    );
  }
}
