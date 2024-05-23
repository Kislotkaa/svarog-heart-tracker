import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';

class BaseGraphicsWidget extends StatelessWidget {
  const BaseGraphicsWidget({
    super.key,
    required this.listHeartRate,
    required this.deviceController,
  });

  final DeviceController deviceController;
  final List<int> listHeartRate;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>?>(
      future: deviceController.getHistory(),
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
                        Colors.transparent,
                      ],
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
            style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
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
      style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
      textAlign: TextAlign.right,
    );
  }
}
