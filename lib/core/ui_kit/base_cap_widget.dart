import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_text_link_widget.dart';

class BaseCapWidget extends StatelessWidget {
  const BaseCapWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.caption,
    required this.onRefresh,
    this.textLink,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String caption;
  final String? textLink;

  final Function()? onRefresh;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => onRefresh?.call(),
        child: ListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.23),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 60,
                          color: appTheme.textGrayColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: appTheme.textTheme.buttonExtrabold16,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          caption,
                          textAlign: TextAlign.center,
                          style: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.textGrayColor),
                        ),
                        const SizedBox(height: 6),
                        BaseTextLinkWidget(textLink ?? '')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
