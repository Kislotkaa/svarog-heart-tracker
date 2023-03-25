import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resourse/app_colors.dart';
import '../resourse/app_const.dart';
import '../resourse/base_icons_icons.dart';

class BaseHistoryUser extends StatelessWidget {
  const BaseHistoryUser({
    super.key,
    required this.personName,
    required this.deviceName,
    required this.isConnected,
    required this.onDelete,
    required this.goToDetail,
  });

  final String? personName;
  final String? deviceName;
  final Future<bool> Function() onDelete;
  final Function() goToDetail;

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        AppConst.borderRadius,
      ),
      child: GestureDetector(
        onTap: () => goToDetail(),
        child: Dismissible(
          key: ValueKey<String>(deviceName ?? ''),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            bool result = await onDelete();
            return result;
          },
          secondaryBackground: Container(
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerRight,
            child: const Icon(
              BaseIcons.trash_full,
              color: AppColors.whiteConst,
            ),
          ),
          background: const SizedBox(),
          child: Container(
            height: 61,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  BaseIcons.person,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        personName ?? 'Empty',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        deviceName ?? 'Empty',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: isConnected
                      ? AppColors.greenConst
                      : AppColors.grayColorLight,
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    ).paddingOnly(bottom: 12);
  }
}
