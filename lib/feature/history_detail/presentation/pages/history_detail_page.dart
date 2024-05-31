import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_main_layout.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_cap_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_icon_button_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/loading/base_linear_progress_indicator.dart';
import 'package:svarog_heart_tracker/feature/dialogs/presentation/pages/confirm_dialog_page.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/history_detail/history_detail_bloc.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/widgets/base_active_stats_widget.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/widgets/base_history_stats_widget.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
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
      buildWhen: (prev, next) => prev.status != next.status || prev.listHistory.length != prev.listHistory.hashCode,
      builder: (context, state) {
        return Stack(
          children: [
            MainLayout(
              floatingActionButton: BaseIconButtonWidget(
                onPressed: () {
                  final userId = state.user?.id;
                  if (userId != null) {
                    router.push(UserEditRoute(userId: userId)).then((value) {
                      sl<HistoryDetailBloc>().add(const HistoryDetailGetUserEvent());
                    });
                  }
                },
                icon: Icons.edit_outlined,
              ),
              title: state.user?.personName ?? 'Empty',
              needCloseButton: true,
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
                            description: 'Вы действительно хотите безвозвратно удалить всю историю?',
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
              body: Builder(
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
                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) => _loadMoreListener(notification),
                    child: RefreshIndicator(
                      color: appTheme.revertBasicColor,
                      onRefresh: () async => _onRefresh(context),
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.listHistory.length,
                              (BuildContext context, int i) {
                                if (i == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<HomeBloc, HomeState>(
                                            buildWhen: (prev, next) => prev.list.hashCode != next.list.hashCode,
                                            builder: (context, homeState) {
                                              final deviceController = homeState.list
                                                  .firstWhereOrNull((element) => element.id == state.user?.id);
                                              return BaseActiveStatsWidget(deviceController: deviceController);
                                            }),
                                        const SizedBox(height: 16),
                                        Text(
                                          'История активности',
                                          style: appTheme.textTheme.subheaderExtrabold18,
                                        ),
                                        const SizedBox(height: 12),
                                        BaseHistoryStatsWidget(
                                          history: state.listHistory[i],
                                          onDelete: (id) => sl<HistoryDetailBloc>().add(HistoryDetailDeleteEvent(id)),
                                          needFullProfile: state.user?.userDetailId?.isEmpty ?? true,
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 12),
                                        BaseHistoryStatsWidget(
                                          history: state.listHistory[i],
                                          onDelete: (id) => sl<HistoryDetailBloc>().add(HistoryDetailDeleteEvent(id)),
                                          needFullProfile: false,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.status == StateStatus.loading)
              const Align(
                alignment: Alignment.bottomCenter,
                child: BaseLinearProgressIndicator(),
              ),
          ],
        );
      },
    );
  }

  bool _loadMoreListener(ScrollNotification notification) {
    if (notification.metrics.extentAfter < 150) {
      sl<HistoryDetailBloc>().add(const HistoryDetailLoadMoreEvent());
    }
    return true;
  }

  void _onRefresh(BuildContext context) => sl<HistoryDetailBloc>().add(const HistoryDetailRefreshEvent());
}
