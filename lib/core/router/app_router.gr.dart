// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutPage(),
      );
    },
    AuthAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthAdminPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    ChooseNameDialogRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseNameDialogRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChooseNameDialogPage(
          title: args.title,
          controller: args.controller,
          onTapConfirm: args.onTapConfirm,
          onTapCancel: args.onTapCancel,
          textConfirm: args.textConfirm,
          textCancel: args.textCancel,
          key: args.key,
        ),
      );
    },
    ConfirmDialogRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmDialogRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConfirmDialogPage(
          title: args.title,
          description: args.description,
          onTapConfirm: args.onTapConfirm,
          onTapCancel: args.onTapCancel,
          textConfirm: args.textConfirm,
          textCancel: args.textCancel,
          key: args.key,
        ),
      );
    },
    HistoryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<HistoryDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HistoryDetailPage(
          key: args.key,
          userId: args.userId,
          deviceController: args.deviceController,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    HowToUseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HowToUsePage(),
      );
    },
    NewDevicesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewDevicesPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    UnknownRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UnknownPage(),
      );
    },
  };
}

/// generated route for
/// [AboutPage]
class AboutRoute extends PageRouteInfo<void> {
  const AboutRoute({List<PageRouteInfo>? children})
      : super(
          AboutRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthAdminPage]
class AuthAdminRoute extends PageRouteInfo<void> {
  const AuthAdminRoute({List<PageRouteInfo>? children})
      : super(
          AuthAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChooseNameDialogPage]
class ChooseNameDialogRoute extends PageRouteInfo<ChooseNameDialogRouteArgs> {
  ChooseNameDialogRoute({
    required String title,
    required TextEditingController controller,
    required dynamic Function()? onTapConfirm,
    required dynamic Function()? onTapCancel,
    required String textConfirm,
    required String textCancel,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChooseNameDialogRoute.name,
          args: ChooseNameDialogRouteArgs(
            title: title,
            controller: controller,
            onTapConfirm: onTapConfirm,
            onTapCancel: onTapCancel,
            textConfirm: textConfirm,
            textCancel: textCancel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChooseNameDialogRoute';

  static const PageInfo<ChooseNameDialogRouteArgs> page = PageInfo<ChooseNameDialogRouteArgs>(name);
}

class ChooseNameDialogRouteArgs {
  const ChooseNameDialogRouteArgs({
    required this.title,
    required this.controller,
    required this.onTapConfirm,
    required this.onTapCancel,
    required this.textConfirm,
    required this.textCancel,
    this.key,
  });

  final String title;

  final TextEditingController controller;

  final dynamic Function()? onTapConfirm;

  final dynamic Function()? onTapCancel;

  final String textConfirm;

  final String textCancel;

  final Key? key;

  @override
  String toString() {
    return 'ChooseNameDialogRouteArgs{title: $title, controller: $controller, onTapConfirm: $onTapConfirm, onTapCancel: $onTapCancel, textConfirm: $textConfirm, textCancel: $textCancel, key: $key}';
  }
}

/// generated route for
/// [ConfirmDialogPage]
class ConfirmDialogRoute extends PageRouteInfo<ConfirmDialogRouteArgs> {
  ConfirmDialogRoute({
    required String title,
    required String description,
    required dynamic Function()? onTapConfirm,
    required dynamic Function()? onTapCancel,
    required String textConfirm,
    required String textCancel,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ConfirmDialogRoute.name,
          args: ConfirmDialogRouteArgs(
            title: title,
            description: description,
            onTapConfirm: onTapConfirm,
            onTapCancel: onTapCancel,
            textConfirm: textConfirm,
            textCancel: textCancel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmDialogRoute';

  static const PageInfo<ConfirmDialogRouteArgs> page = PageInfo<ConfirmDialogRouteArgs>(name);
}

class ConfirmDialogRouteArgs {
  const ConfirmDialogRouteArgs({
    required this.title,
    required this.description,
    required this.onTapConfirm,
    required this.onTapCancel,
    required this.textConfirm,
    required this.textCancel,
    this.key,
  });

  final String title;

  final String description;

  final dynamic Function()? onTapConfirm;

  final dynamic Function()? onTapCancel;

  final String textConfirm;

  final String textCancel;

  final Key? key;

  @override
  String toString() {
    return 'ConfirmDialogRouteArgs{title: $title, description: $description, onTapConfirm: $onTapConfirm, onTapCancel: $onTapCancel, textConfirm: $textConfirm, textCancel: $textCancel, key: $key}';
  }
}

/// generated route for
/// [HistoryDetailPage]
class HistoryDetailRoute extends PageRouteInfo<HistoryDetailRouteArgs> {
  HistoryDetailRoute({
    Key? key,
    required String userId,
    required DeviceController deviceController,
    List<PageRouteInfo>? children,
  }) : super(
          HistoryDetailRoute.name,
          args: HistoryDetailRouteArgs(
            key: key,
            userId: userId,
            deviceController: deviceController,
          ),
          initialChildren: children,
        );

  static const String name = 'HistoryDetailRoute';

  static const PageInfo<HistoryDetailRouteArgs> page = PageInfo<HistoryDetailRouteArgs>(name);
}

class HistoryDetailRouteArgs {
  const HistoryDetailRouteArgs({
    this.key,
    required this.userId,
    required this.deviceController,
  });

  final Key? key;

  final String userId;

  final DeviceController deviceController;

  @override
  String toString() {
    return 'HistoryDetailRouteArgs{key: $key, userId: $userId, deviceController: $deviceController}';
  }
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HowToUsePage]
class HowToUseRoute extends PageRouteInfo<void> {
  const HowToUseRoute({List<PageRouteInfo>? children})
      : super(
          HowToUseRoute.name,
          initialChildren: children,
        );

  static const String name = 'HowToUseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewDevicesPage]
class NewDevicesRoute extends PageRouteInfo<void> {
  const NewDevicesRoute({List<PageRouteInfo>? children})
      : super(
          NewDevicesRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewDevicesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UnknownPage]
class UnknownRoute extends PageRouteInfo<void> {
  const UnknownRoute({List<PageRouteInfo>? children})
      : super(
          UnknownRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnknownRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
