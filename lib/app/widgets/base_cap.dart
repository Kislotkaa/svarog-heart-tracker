import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_text_link.dart';

class BaseCapScreen extends StatelessWidget {
  const BaseCapScreen({
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

  final Function() onRefresh;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(),
        child: ListView(
          padding: EdgeInsets.only(top: Get.height * 0.23),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 60,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          caption,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(height: 6),
                        BaseTextLink(textLink ?? '')
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
