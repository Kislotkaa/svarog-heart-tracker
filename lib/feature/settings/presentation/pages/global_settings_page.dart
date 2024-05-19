import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/bloc/global_settings/global_settings_bloc.dart';
import 'package:svarog_heart_tracker/feature/settings/presentation/widgets/base_slider_global_settings_widget.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class GlobalSettingsPage extends StatelessWidget {
  const GlobalSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBarWidget(
        title: 'Глобальные настройки',
        needClose: true,
        actions: [
          IconButton(
            onPressed: () => sl<GlobalSettingsBloc>().add(const GlobalSettingsSetToDefaultEvent()),
            icon: const Icon(Icons.settings_backup_restore_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GlobalSettingsBloc, GlobalSettingsState>(
          buildWhen: (prev, next) => prev.globalSettingsModel.hashCode != next.globalSettingsModel.hashCode,
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                BaseSliderGlobalSettingsWidget(
                  value:
                      state.globalSettingsModel?.timeSavedData ?? sl<GlobalSettingsService>().appSettings.timeSavedData,
                  minValue: 10,
                  maxValue: 600,
                  title: "Необходимая длительность тренировки в секундах, что бы данные тренировки были сохранены",
                  slug: 'сек',
                  onChanged: (value) => sl<GlobalSettingsBloc>().add(
                    GlobalSettingsUpdateEvent(
                      timeSavedData: value,
                    ),
                  ),
                ),
                BaseSliderGlobalSettingsWidget(
                  value: state.globalSettingsModel?.timeDisconnect ??
                      sl<GlobalSettingsService>().appSettings.timeDisconnect,
                  minValue: 10,
                  maxValue: 240,
                  title: "Время отсутсвия связи с датчиком в секундах, после которого произойдёт отключение",
                  slug: 'сек',
                  onChanged: (value) => sl<GlobalSettingsBloc>().add(
                    GlobalSettingsUpdateEvent(
                      timeDisconnect: value,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
