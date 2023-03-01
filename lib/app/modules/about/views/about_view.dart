import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/widgets/base_text_link.dart';
import 'package:svarog_heart_tracker/app/widgets/base_version.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.goToBack(),
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/appIcon.svg',
                    height: 150,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Сварог',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Тренировочный комплекс для пожарных и спасателей',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () async {
                      launchUrl(Uri.parse('https://dimokamera.ru'));
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.1,
                        vertical: Get.height * 0.03,
                      ),
                      child: const BaseTextLink('dimokamera.ru'),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SafeArea(
                child: BaseVersion(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
