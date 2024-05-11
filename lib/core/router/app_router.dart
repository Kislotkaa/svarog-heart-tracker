import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/choose_name_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/confirm_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/pages/new_devices_page.dart';
import 'package:svarog_heart_tracker/feature/about/presentation/pages/about_page.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/pages/auth_page.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/pages/auth_admin_page.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/pages/history_page.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/pages/history_detail_page.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/pages/home_page.dart';
import 'package:svarog_heart_tracker/feature/hot_to_use/pages/how_to_use_page.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/pages/settings_page.dart';
import 'package:svarog_heart_tracker/feature/splash/presentation/pages/splash_page.dart';
import 'package:svarog_heart_tracker/feature/unknown/pages/unknown_page.dart';
import 'package:svarog_heart_tracker/locator.dart';

part 'app_router.gr.dart';

AppRouter get router => sl<AppRouter>();

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          path: '/',
          page: SplashRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          path: '/home',
          page: HomeRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/settings',
          page: SettingsRoute.page,
          durationInMilliseconds: 150,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          path: '/about',
          page: AboutRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/history',
          page: HistoryRoute.page,
          durationInMilliseconds: 150,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          path: '/history_detail',
          page: HistoryDetailRoute.page,
          durationInMilliseconds: 150,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute(
          path: '/how_to_use',
          page: HowToUseRoute.page,
          durationInMilliseconds: 150,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        CustomRoute(
          path: '/auth',
          page: AuthRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/auth_admin',
          page: AuthAdminRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/new_devices',
          page: NewDevicesRoute.page,
          durationInMilliseconds: 150,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        CustomRoute(
          path: '/confirm_dialog',
          page: ConfirmDialogRoute.page,
          durationInMilliseconds: 150,
          opaque: false,
          barrierColor: appTheme.revertBasicColor.withOpacity(0.5),
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '/choose_name_dialog',
          page: ChooseNameDialogRoute.page,
          durationInMilliseconds: 150,
          opaque: false,
          barrierColor: appTheme.revertBasicColor.withOpacity(0.5),
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          path: '*',
          page: UnknownRoute.page,
          durationInMilliseconds: 150,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
      ];
}
