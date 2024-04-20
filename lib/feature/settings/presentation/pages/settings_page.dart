import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/config/env.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_app_bar.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_global_loading.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_version.dart';
import 'package:svarog_heart_tracker/core/utils/service/database_service.dart/sqllite_service.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/widgets/base_settings.dart';
import 'package:svarog_heart_tracker/locator.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Настройки',
        needClose: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'История',
                              style: appTheme.textTheme.buttonExtrabold16,
                            ),
                            BaseSettings(
                              onTap: () => router.push(const HistoryRoute()),
                              leftWidget: Icon(
                                Icons.wysiwyg_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'История',
                              rightWidget: const Icon(Icons.keyboard_arrow_right_rounded),
                            ),
                            if (!sl<SqlLiteService>().isEmpty)
                              BaseSettings(
                                onTap: () => sl<SettingsBloc>().add(const SettingsDeleteHistoryEvent()),
                                leftWidget: Icon(
                                  Icons.signal_cellular_no_sim_outlined,
                                  color: appTheme.errorColor,
                                ),
                                text: 'Отчистить историю',
                                textColor: appTheme.errorColor,
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Дополнительные',
                              style: appTheme.textTheme.buttonExtrabold16,
                            ),
                            BaseSettings(
                              onTap: () => router.push(const AboutRoute()),
                              leftWidget: Icon(
                                Icons.warning_amber_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'О нас',
                            ),
                            BaseSettings(
                              onTap: () => router.push(const HowToUseRoute()),
                              leftWidget: Icon(
                                Icons.question_mark,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'Как пользоваться',
                            ),
                            BaseSettings(
                              onTap: () => launchUrl(Uri.parse(EnvironmentConfig.APP_POLIT_URL)),
                              leftWidget: Icon(
                                Icons.document_scanner_outlined,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'Политика конфиденциальности',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Аккаунт',
                              style: appTheme.textTheme.buttonExtrabold16,
                            ),
                            BaseSettings(
                              onTap: () => sl<SettingsBloc>().add(const SettingsLogoutEvent()),
                              leftWidget: Icon(
                                Icons.exit_to_app_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'Выйти с аккаунта',
                            ),
                            BaseSettings(
                              onTap: () => sl<SettingsBloc>().add(const SettingsDeleteAccountEvent()),
                              leftWidget: Icon(
                                Icons.close,
                                color: appTheme.errorColor,
                              ),
                              text: 'Удалить аккаунт',
                              textColor: appTheme.errorColor,
                            ),
                            const SizedBox(height: 32),
                            const BaseVersion(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (state.status == StateStatus.loading) const BaseGlobalLoading(),
            ],
          );
        },
      ),
    );
  }
}
