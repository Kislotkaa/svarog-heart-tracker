import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_flexible_widget.dart';

class BaseBlurTransparentSliverAppBar extends StatelessWidget {
  const BaseBlurTransparentSliverAppBar({
    required this.text,
    this.actions = const [],
    this.leadingWidget,
    this.flexibleSpace = const FlexibleWidget(),
    Key? key,
  }) : super(key: key);

  final List<Widget> actions;
  final Widget flexibleSpace;
  final String text;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    final sliverAppBar = SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      elevation: 0.0,
      leadingWidth: 48,
      leading: leadingWidget,
      backgroundColor: Colors.transparent,
      flexibleSpace: flexibleSpace,
      centerTitle: false,
      title: Text(
        text,
        style: appTheme.textTheme.bodySemibold16,
      ),
      actions: actions,
    );

    return sliverAppBar;
  }
}
