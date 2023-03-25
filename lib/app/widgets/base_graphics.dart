import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_colors.dart';

class BaseGraphics extends StatelessWidget {
  const BaseGraphics({
    super.key,
    required this.listHeartRate,
    required this.getHistory,
  });

  final List<int> listHeartRate;
  final Function() getHistory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>?>(
      future: getHistory(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<FlSpot> listSpot = [];
          for (var i = 0; i < snapshot.data!.length; i++) {
            listSpot.add(FlSpot(i.toDouble(), snapshot.data![i].toDouble()));
          }
          return LineChart(
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
              minY: snapshot.data!.min.toDouble(),
              maxY: snapshot.data!.max.toDouble(),
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
          );
        } else {
          return Center(
              child: Text(
            'График ещё не готов',
            style: Theme.of(context).textTheme.caption,
            maxLines: 1,
            textAlign: TextAlign.center,
          ));
        }
      },
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
