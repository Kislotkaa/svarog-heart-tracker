import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/date_format.dart';
import '../helper/time_format.dart';
import '../models/user_history_model.dart';
import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';
import '../resourse/base_icons_icons.dart';

class BaseHistoryStats extends StatelessWidget {
  BaseHistoryStats({
    super.key,
    required this.history,
    required this.onDelete,
  });

  final UserHistoryModel? history;
  final Future<bool?> Function(String? id) onDelete;

  @override
  Widget build(BuildContext context) {
    List<FlSpot> listSpot = [];
    for (var i = 0; i < history!.yHeart.length; i++) {
      listSpot.add(FlSpot(i.toDouble(), history!.yHeart[i].toDouble()));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dateFormatDefault(history?.createAt ?? DateTime.now()),
                style: Theme.of(context).textTheme.caption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).paddingOnly(left: 6, bottom: 4),
            ),
            Expanded(
              child: Text(
                dateFormatDuration(
                      history?.createAt,
                      history?.finishedAt,
                    ) ??
                    '',
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.caption,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).paddingOnly(right: 6, bottom: 4),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            AppConst.borderRadius,
          ),
          child: Dismissible(
            key: ValueKey<String>(history?.id ?? ''),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              bool? result = await onDelete(history?.id);
              return result ?? false;
            },
            secondaryBackground: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerRight,
              child: const Icon(
                BaseIcons.trash_full,
                color: AppColors.whiteConst,
              ),
            ),
            background: const SizedBox(),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 10, right: 16, left: 16, bottom: 16),
              height: 105,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText.rich(
                        TextSpan(
                          text: 'max: ',
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                              text: history!.maxHeart.toString(),
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
                              text: history!.minHeart.toString(),
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
                              text: history!.avgHeart.toString(),
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
                  ).paddingOnly(right: 12),
                  Column(
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
                                history!.redTimeHeart,
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
                                history!.orangeTimeHeart,
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
                                history!.greenTimeHeart,
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
                  ).paddingOnly(right: 12),
                  Expanded(
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
                        minY: history!.yHeart.min.toDouble() -
                            history!.yHeart.min / 2,
                        maxY: history!.yHeart.max.toDouble() +
                            history!.yHeart.max / 2,
                        lineBarsData: [
                          LineChartBarData(
                            spots: listSpot,
                            isCurved: true,
                            color: AppColors.redConst,
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
                                colors: AppColors.gradientGraphicsColors
                                    .map((color) => color.withOpacity(0.9))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      value.toString(),
      style: Theme.of(Get.context!).textTheme.caption!,
      textAlign: TextAlign.right,
    );
  }
}
