import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/config/env.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/database/hive_service.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/loading/base_global_loading_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_version_widget.dart';
import 'package:svarog_heart_tracker/core/service/database/sqllite_service.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/confirm_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/settings/settings_bloc.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/widgets/base_settings_widget.dart';
import 'package:svarog_heart_tracker/locator.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: const BaseAppBarWidget(
                title: 'Настройки',
                needClose: true,
              ),
              body: Stack(
                children: [
                  SafeArea(
                    child: ListView(
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
                            BaseSettingsWidget(
                              onTap: () => router.push(const HistoryRoute()),
                              leftWidget: Icon(
                                Icons.wysiwyg_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'История',
                              rightWidget: const Icon(Icons.keyboard_arrow_right_rounded),
                            ),
                            FutureBuilder(
                              future: sl<GlobalSettingsService>().appSettings.isMigratedHive
                                  ? sl<HiveService>().dataBaseIsEmpty()
                                  : sl<SqlLiteService>().dataBaseIsEmpty(),
                              builder: (context, snapshot) {
                                if (snapshot.data == false) {
                                  return BaseSettingsWidget(
                                    onTap: () {
                                      showConfirmDialog(
                                        context: context,
                                        title: 'Отчистить историю?',
                                        description: 'Вы действительно хотите удалить историю и всё что с ней связано?',
                                        onTapConfirm: () {
                                          Navigator.pop(context);
                                          sl<SettingsBloc>().add(const SettingsDeleteHistoryEvent());
                                        },
                                        onTapCancel: () => Navigator.pop(context),
                                        textConfirm: 'Подтвердить',
                                        textCancel: 'Отмена',
                                      );
                                    },
                                    leftWidget: Icon(
                                      Icons.delete_outline_rounded,
                                      color: appTheme.errorColor,
                                    ),
                                    text: 'Отчистить историю',
                                    textColor: appTheme.errorColor,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Дополнительные',
                              style: appTheme.textTheme.buttonExtrabold16,
                            ),
                            BaseSettingsWidget(
                              onTap: () => router.push(const GlobalSettingsRoute()),
                              leftWidget: Icon(
                                Icons.warning_amber_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'Настройки',
                            ),
                            BlocBuilder<ThemeCubit, ThemeState>(
                              builder: (context, state) {
                                return BaseSettingsWidget(
                                  onTap: () => sl<ThemeCubit>().switchTheme(),
                                  leftWidget: Icon(
                                    Icons.light_mode_outlined,
                                    color: appTheme.textGrayColor,
                                  ),
                                  rightWidget: CupertinoSwitch(
                                    value: state.isDarkMode,
                                    onChanged: (_) => sl<ThemeCubit>().switchTheme(),
                                  ),
                                  text: 'Темная тема',
                                );
                              },
                            ),
                            BaseSettingsWidget(
                              onTap: () => router.push(const AboutRoute()),
                              leftWidget: Icon(
                                Icons.warning_amber_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'О нас',
                            ),
                            BaseSettingsWidget(
                              onTap: () => router.push(const HowToUseRoute()),
                              leftWidget: Icon(
                                Icons.question_mark,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'Как пользоваться',
                            ),
                            BaseSettingsWidget(
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
                            BaseSettingsWidget(
                              onTap: () {
                                showConfirmDialog(
                                  context: context,
                                  title: 'Выйти?',
                                  description: 'Вы действительно хотите выйти с аккаунта?',
                                  textConfirm: 'Подтвердить',
                                  textCancel: 'Отмена',
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    sl<SettingsBloc>().add(const SettingsLogoutEvent());
                                  },
                                  onTapCancel: () => Navigator.pop(context),
                                );
                              },
                              leftWidget: Icon(
                                Icons.exit_to_app_rounded,
                                color: appTheme.textGrayColor,
                              ),
                              text: 'Выйти с аккаунта',
                            ),
                            BaseSettingsWidget(
                              onTap: () {
                                showConfirmDialog(
                                  context: context,
                                  title: 'Удалить аккаунт?',
                                  description: 'Вы действительно хотите удалить аккаунт?',
                                  textConfirm: 'Подтвердить',
                                  textCancel: 'Отмена',
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    sl<SettingsBloc>().add(const SettingsDeleteAccountEvent());
                                  },
                                  onTapCancel: () => Navigator.pop(context),
                                );
                              },
                              leftWidget: Icon(
                                Icons.close,
                                color: appTheme.errorColor,
                              ),
                              text: 'Удалить аккаунт',
                              textColor: appTheme.errorColor,
                            ),
                            const SizedBox(height: 32),
                            const BaseVersionWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (state.status == StateStatus.loading) const BaseGlobalLoadingWidget(),
          ],
        );
      },
    );
  }
}
