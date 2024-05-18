import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_circular_progress_indicator_widget.dart';
import 'package:svarog_heart_tracker/feature/splash/presentation/bloc/splash_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    sl<SplashBloc>().add(const SplashInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (BuildContext context, state) {
          if (state.errorTitle != null) {
            AppSnackbar.showTextFloatingSnackBar(
              title: state.errorTitle ?? '',
              description: state.errorMessage ?? '',
              overlayState: Overlay.of(context),
              status: SnackStatusEnum.warning,
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BaseCircularProgressIndicatorWidget(
                  padding: EdgeInsets.only(bottom: 16),
                ),
                Text(
                  state.process ?? '',
                  textAlign: TextAlign.center,
                  style: appTheme.textTheme.smallCaptionSemibold12,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
