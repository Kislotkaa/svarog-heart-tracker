import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/theme/utils/duration.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_button_widget.dart';

@RoutePage()
class ZoneEditPage extends StatefulWidget {
  final TextEditingController greenZone;
  final TextEditingController orangeZone;

  const ZoneEditPage({
    Key? key,
    required this.greenZone,
    required this.orangeZone,
  }) : super(key: key);

  @override
  State<ZoneEditPage> createState() => _ZoneEditPageState();
}

class _ZoneEditPageState extends State<ZoneEditPage> {
  late CrossFadeState crossFadeState = CrossFadeState.showFirst;
  late int valueGreenZone = int.tryParse(widget.greenZone.text) ?? 0;
  late int valueOrangeZone = int.tryParse(widget.orangeZone.text) ?? 0;

  @override
  void initState() {
    super.initState();
  }

  void changedGreenVoid(int value) {
    setState(() {
      if (valueGreenZone + value < 0) {
        valueGreenZone = 0;
      } else {
        valueGreenZone = valueGreenZone + value;
      }
    });
  }

  void changedOrangeVoid(int value) {
    setState(() {
      if (valueOrangeZone + value < 0) {
        valueOrangeZone = 0;
      } else {
        valueOrangeZone = valueOrangeZone + value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.basicColor,
      appBar: BaseAppBarWidget(
        title: 'Редактирование зон',
        needClose: false,
        leadingWidget: GestureDetector(
          onTap: () {
            setState(() {
              if (crossFadeState == CrossFadeState.showSecond) {
                crossFadeState = CrossFadeState.showFirst;
              } else {
                router.removeLast();
              }
            });
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedCrossFade(
            alignment: Alignment.center,
            firstChild: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueChanged(
                      changed: -10,
                      onSuccess: (value) => changedGreenVoid(value),
                    ),
                    ValueChanged(
                      changed: -1,
                      onSuccess: (value) => changedGreenVoid(value),
                      margin: const EdgeInsets.only(top: 8),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: appTheme.greenColor, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: double.infinity,
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        valueGreenZone.toString(),
                        style: appTheme.textTheme.headerExtrabold20,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ValueChanged(
                      changed: 1,
                      onSuccess: (value) => changedGreenVoid(value),
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    ValueChanged(
                      changed: 10,
                      onSuccess: (value) => changedGreenVoid(value),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BaseButtonWidget(
                    onPressed: () {
                      setState(() {
                        crossFadeState = CrossFadeState.showSecond;
                      });
                    },
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Далее',
                      style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.revertTextColor),
                    ),
                  ),
                ),
              ],
            ),
            secondChild: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueChanged(
                      changed: -10,
                      onSuccess: (value) => changedOrangeVoid(value),
                    ),
                    ValueChanged(
                      changed: -1,
                      onSuccess: (value) => changedOrangeVoid(value),
                      margin: const EdgeInsets.only(top: 8),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: appTheme.yellowColor, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: double.infinity,
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        valueGreenZone.toString(),
                        style: appTheme.textTheme.headerExtrabold20,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ValueChanged(
                      changed: 1,
                      onSuccess: (value) => changedOrangeVoid(value),
                      margin: const EdgeInsets.only(bottom: 8),
                    ),
                    ValueChanged(
                      changed: 10,
                      onSuccess: (value) => changedOrangeVoid(value),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BaseButtonWidget(
                    onPressed: () {},
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Готово',
                      style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.revertTextColor),
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: crossFadeState,
            duration: AppDuration.fast,
            reverseDuration: AppDuration.fast,
          ),
        ),
      ),
    );
  }
}

class ValueChanged extends StatelessWidget {
  const ValueChanged({
    super.key,
    this.margin,
    required this.changed,
    required this.onSuccess,
  });

  final int changed;
  final EdgeInsets? margin;
  final Function(int value) onSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSuccess(changed),
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          color: appTheme.revertBasicColor,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 50,
        alignment: Alignment.center,
        child: Text(
          '$changed',
          style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.basicColor),
        ),
      ),
    );
  }
}
