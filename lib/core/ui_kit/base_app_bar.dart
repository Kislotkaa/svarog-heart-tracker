import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leadingWidget;
  final bool needClose;
  const BaseAppBar({
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
      leadingWidth: leadingWidget != null || needClose == true ? 72 : 0,
      leading: Builder(builder: (context) {
        if (needClose) {
          return IconButton(
            onPressed: () {
              router.removeLast();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: leadingWidget,
        );
      }),
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Text(
        title,
        style: appTheme.textTheme.bodySemibold16,
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
