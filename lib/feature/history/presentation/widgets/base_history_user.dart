import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/feature/history/presentation/bloc/history_bloc.dart';
import 'package:svarog_heart_tracker/feature/home/presentation/bloc/home/home_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

class BaseHistoryUser extends StatelessWidget {
  const BaseHistoryUser({
    super.key,
    required this.user,
    required this.goToDetail,
    required this.isConnected,
  });

  final UserModel user;
  final bool isConnected;

  final Function() goToDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: () => goToDetail(),
          child: Dismissible(
            key: ValueKey<String>(user.deviceName),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              if (sl<HomeBloc>().state.list.firstWhereOrNull((element) => element.id == user.id) != null) {
                AppSnackbar.showTextFloatingSnackBar(
                  title: 'Предупреждение',
                  description: 'В момент активности пользователя удалять историю подключения запрещено!',
                  overlayState: Overlay.of(context),
                  status: SnackStatusEnum.warning,
                );
                return false;
              }
              sl<HistoryBloc>().add(DeleteHistoryEvent(id: user.id));
              return true;
            },
            secondaryBackground: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete_outline_rounded,
                color: appTheme.alwaysWhiteTextColor,
              ),
            ),
            background: const SizedBox(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.person_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.personName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appTheme.textTheme.bodySemibold16,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.deviceName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: isConnected ? appTheme.greenColor : appTheme.grayColor,
                    size: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
