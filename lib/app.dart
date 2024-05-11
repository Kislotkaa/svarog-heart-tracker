import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:svarog_heart_tracker/core/cubit/intl_cubit/intl_cubit.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/l10n/generated/l10n.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/utils/routing_observer.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth_admin/auth_admin_bloc.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/bloc/history_bloc.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/history_detail_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/auto_connect/auto_connect_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connect_device/connect_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/previously_connected/previously_connected_bloc.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/scan_device/scan_device_bloc.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:svarog_heart_tracker/feature/splash/presentation/bloc/splash_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart' as di;
import 'package:svarog_heart_tracker/locator.dart';

final GlobalKey _key = GlobalKey();
BuildContext get externalContext => _key.currentContext!;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Bloc
        BlocProvider<AuthAdminBloc>(create: (context) => di.sl<AuthAdminBloc>()),
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
        BlocProvider<SplashBloc>(create: (context) => di.sl<SplashBloc>()),
        BlocProvider<HomeBloc>(create: (context) => di.sl<HomeBloc>()),
        BlocProvider<SettingsBloc>(create: (context) => di.sl<SettingsBloc>()),
        BlocProvider<ConnectedDeviceBloc>(create: (context) => di.sl<ConnectedDeviceBloc>()),
        BlocProvider<ConnectDeviceBloc>(create: (context) => di.sl<ConnectDeviceBloc>()),
        BlocProvider<PreviouslyConnectedBloc>(create: (context) => di.sl<PreviouslyConnectedBloc>()),
        BlocProvider<ScanDeviceBloc>(create: (context) => di.sl<ScanDeviceBloc>()),
        BlocProvider<HistoryDetailBloc>(create: (context) => di.sl<HistoryDetailBloc>()),
        BlocProvider<AutoConnectBloc>(create: (context) => di.sl<AutoConnectBloc>()),
        BlocProvider<HistoryBloc>(create: (context) => di.sl<HistoryBloc>()),

        // Cubit
        BlocProvider<ThemeCubit>(create: (context) => di.sl<ThemeCubit>()),
        BlocProvider<IntlCubit>(create: (context) => di.sl<IntlCubit>())
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) => di.sl<ThemeCubit>().rebuildAllChildren(context),
        listenWhen: (prev, current) => prev.isDarkMode != current.isDarkMode,
        builder: (context, themeState) => BlocBuilder<IntlCubit, IntlState>(
          builder: (_, intlState) => MaterialApp.router(
            key: _key,
            locale: Locale(intlState.languageCode),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'Heart tracker',
            theme: sl<ThemeCubit>().getLightThemeData(),
            darkTheme: sl<ThemeCubit>().getDarkThemeData(),
            themeMode: themeState.themeMode,
            routerConfig: sl<AppRouter>().config(
              navigatorObservers: () => [RoutingObserver()],
            ),
          ),
        ),
      ),
    );
  }
}
