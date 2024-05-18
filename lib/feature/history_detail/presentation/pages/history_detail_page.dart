import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_cap_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_circular_progress_indicator_widget.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/confirm_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/history_detail_bloc.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/widgets/base_active_stats_widget.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/widgets/base_history_stats_widget.dart';
import 'package:svarog_heart_tracker/feature/home/utils/device_controller.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({Key? key, required this.userId, this.deviceController}) : super(key: key);

  final String userId;
  final DeviceController? deviceController;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  void initState() {
    sl<HistoryDetailBloc>().add(HistoryDetailInitialEvent(widget.userId, widget.deviceController));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBarWidget(
            title: state.user?.personName ?? 'Empty',
            needClose: true,
            actions: [
              Text(
                'Авто\nсопряжение',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: appTheme.textTheme.smallCaptionSemibold12,
              ),
              CupertinoSwitch(
                onChanged: (bool value) => sl<HistoryDetailBloc>().add(const HistoryDetailSwitchAutoConnectEvent()),
                value: state.user?.isAutoConnect ?? false,
              ),
              state.listHistory.isNotEmpty
                  ? GestureDetector(
                      child: const Icon(Icons.delete_outline_rounded),
                      onTap: () {
                        showConfirmDialog(
                          context: context,
                          title: 'Удалить всю историю?',
                          description: 'Вы действительно хотите зевозвратно удалть всю историю?',
                          onTapConfirm: () {
                            router.removeLast();
                            sl<HistoryDetailBloc>().add(const HistoryDetailDeleteAllEvent());
                          },
                          onTapCancel: () => router.removeLast(),
                          textConfirm: 'Подтвердить',
                          textCancel: 'Отмена',
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
          body: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        if (state.listHistory.isEmpty) {
                          return const Column(
                            children: [
                              BaseCapWidget(
                                title: 'История отсутсвует',
                                caption: 'Начните пользоваться приложением и история тренировок будет пополняться',
                                icon: Icons.help_outline_rounded,
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          itemCount: state.listHistory.length,
                          itemBuilder: (context, i) {
                            if (i == 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BaseActiveStatsWidget(deviceController: state.deviceController),
                                  const SizedBox(height: 16),
                                  Text(
                                    'История активности',
                                    style: appTheme.textTheme.subheaderExtrabold18,
                                  ),
                                  const SizedBox(height: 12),
                                  BaseHistoryStatsWidget(
                                    history: state.listHistory[i],
                                    onDelete: (id) => sl<HistoryDetailBloc>().add(HistoryDetailDeleteEvent(id)),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  BaseHistoryStatsWidget(
                                    history: state.listHistory[i],
                                    onDelete: (id) => sl<HistoryDetailBloc>().add(HistoryDetailDeleteEvent(id)),
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (state.status == StateStatus.loading)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: BaseLinearProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
