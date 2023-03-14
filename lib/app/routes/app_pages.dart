import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/admin_panel/bindings/admin_panel_binding.dart';
import '../modules/admin_panel/views/admin_panel_view.dart';
import '../modules/admin_set_password/bindings/admin_set_password_binding.dart';
import '../modules/admin_set_password/views/admin_set_password_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/how_to_use/bindings/how_to_use_binding.dart';
import '../modules/how_to_use/views/how_to_use_view.dart';
import '../modules/init/bindings/init_binding.dart';
import '../modules/init/views/init_view.dart';
import '../modules/new_devices/bindings/new_devices_binding.dart';
import '../modules/new_devices/views/new_devices_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../resourse/app_duration.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INIT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: AppDuration.slow,
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: AppDuration.fast,
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: AppDuration.slow,
    ),
    GetPage(
      name: _Paths.NEW_DEVICES,
      page: () => const NewDevicesView(),
      binding: NewDevicesBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
      transition: Transition.downToUp,
      transitionDuration: AppDuration.fast,
    ),
    GetPage(
      name: _Paths.HOW_TO_USE,
      page: () => const HowToUseView(),
      binding: HowToUseBinding(),
      transition: Transition.downToUp,
      transitionDuration: AppDuration.fast,
    ),
    GetPage(
      name: _Paths.INIT,
      page: () => const InitView(),
      binding: InitBinding(),
      transition: Transition.fadeIn,
      transitionDuration: AppDuration.slow,
    ),
    GetPage(
      name: _Paths.ADMIN_PANEL,
      page: () => const AdminPanelView(),
      binding: AdminPanelBinding(),
      transition: Transition.fadeIn,
      transitionDuration: AppDuration.slow,
    ),
    GetPage(
      name: _Paths.ADMIN_SET_PASSWORD,
      page: () => const AdminSetPasswordView(),
      binding: AdminSetPasswordBinding(),
    ),
  ];
}
