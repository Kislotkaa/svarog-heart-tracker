import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/widgets/base_history_user.dart';
import 'package:svarog_heart_tracker/feature/new_devices/presentation/bloc/connected_device/connected_device_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

class BaseListHistory extends StatelessWidget {
  const BaseListHistory({
    super.key,
    required this.users,
    required this.onRefresh,
  });

  final List<UserModel?> users;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    List<Widget> userActive = [];
    List<Widget> userUnActive = [];

    for (var element in users) {
      if (isConnected(element?.id)) {
        if (element != null) {
          userActive.add(
            BaseHistoryUser(
              user: element,
              isConnected: true,
              goToDetail: () => router.push(HistoryDetailRoute(userId: element.id)),
            ),
          );
        }
      } else {
        if (element != null) {
          userUnActive.add(
            BaseHistoryUser(
              user: element,
              isConnected: false,
              goToDetail: () => router.push(HistoryDetailRoute(userId: element.id)),
            ),
          );
        }
      }
    }

    return RefreshIndicator(
      onRefresh: () async => await onRefresh(),
      child: BlocBuilder<ConnectedDeviceBloc, ConnectedDeviceState>(
          buildWhen: (prev, next) => prev.connectedDevices.length != next.connectedDevices.length,
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userActive.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Активные',
                                style: appTheme.textTheme.buttonExtrabold16,
                              ),
                              const SizedBox(height: 16),
                              Column(children: userActive),
                            ],
                          )
                        : const SizedBox(),
                    userUnActive.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Неактивные',
                                style: appTheme.textTheme.buttonExtrabold16,
                              ),
                              const SizedBox(height: 16),
                              Column(children: userUnActive),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            );
          }),
    );
  }

  bool isConnected(String? id) {
    final connectedDevices = sl<ConnectedDeviceBloc>().state.connectedDevices;
    if (id != null) {
      final result = connectedDevices.firstWhereOrNull((element) => element.deviceId == id);
      return result == null ? false : true;
    }
    return false;
  }
}
