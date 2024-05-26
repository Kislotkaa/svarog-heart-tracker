import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';

class BaseAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leadingWidget;
  final bool needClose;
  const BaseAppBarWidget({
    Key? key,
    required this.title,
    this.actions = const [],
    this.leadingWidget,
    this.needClose = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leadingWidth: 0,
      backgroundColor: appTheme.basicColor,
      leading: const SizedBox(),
      centerTitle: false,
      title: Row(
        children: [
          Builder(
            builder: (context) {
              if (needClose) {
                return IconButton(
                  padding: const EdgeInsets.only(right: 16),
                  onPressed: () {
                    router.removeLast();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: leadingWidget,
              );
            },
          ),
          Expanded(
            child: Text(
              title,
              style: appTheme.textTheme.bodySemibold16,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: actions,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
