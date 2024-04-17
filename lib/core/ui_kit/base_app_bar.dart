import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leadingWidget;
  const BaseAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
    this.leadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: leadingWidget,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Text(
        title,
        style: appTheme.textTheme.bodySemibold16,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
