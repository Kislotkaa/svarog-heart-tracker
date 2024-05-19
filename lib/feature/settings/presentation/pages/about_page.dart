import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/common/assets.gen.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_text_link_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_version_widget.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => router.removeLast(),
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(tag: 'appIcon.svg', child: Assets.icons.appIcon.svg(height: 150)),
                  const SizedBox(height: 16),
                  Text(
                    'Сварог',
                    style: appTheme.textTheme.headerExtrabold20.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Тренировочный комплекс для пожарных и спасателей',
                    style: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.textGrayColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () async {
                      launchUrl(Uri.parse('https://dimokamera.ru'));
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: const BaseTextLinkWidget('dimokamera.ru'),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 16,
              right: 0,
              left: 0,
              child: SafeArea(
                child: BaseVersionWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
