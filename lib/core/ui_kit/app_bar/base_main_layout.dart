import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_flexible_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/blur_transparent_sliver_app_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    Key? key,
    required this.body,
    required this.title,
    this.actions = const [],
    this.leadingWidget,
    this.flexibleSpace,
    this.bottomNavigationBar,
    this.titleWidget,
    this.needCloseButton = false,
    this.floatingActionButton,
  }) : super(key: key);

  final String title;
  final Widget? flexibleSpace;
  final Widget? bottomNavigationBar;
  final Widget? titleWidget;
  final List<Widget> actions;
  final Widget? leadingWidget;
  final Widget? floatingActionButton;

  final Widget body;
  final bool needCloseButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      floatingActionButton: floatingActionButton,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            BaseBlurTransparentSliverAppBar(
              title: title,
              flexibleSpace: flexibleSpace ?? const FlexibleWidget(),
              actions: [
                ...actions,
                const SizedBox(width: 16),
              ],
              leadingWidget: needCloseButton
                  ? IconButton(
                      padding: const EdgeInsets.only(left: 16),
                      onPressed: () {
                        router.removeLast();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    )
                  : leadingWidget,
            )
          ];
        },
        body: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
