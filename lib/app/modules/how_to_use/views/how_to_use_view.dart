import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:svarog_heart_tracker/app/helper/screan_helper.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button.dart';
import 'package:svarog_heart_tracker/app/widgets/base_button_text.dart';
import 'package:svarog_heart_tracker/app/widgets/base_divider.dart';

import '../controllers/how_to_use_controller.dart';

class HowToUseView extends GetView<HowToUseController> {
  const HowToUseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<double>? presetFontSizes = [0];
    presetFontSizes = getTextSizeAdaptive();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: SvgPicture.asset(
                'assets/images/body.svg',
              ),
            ),
            Expanded(
              flex: 13,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        _buildTextDefault(
                          'Ремешок следует надевать на слегка ',
                          context,
                        ),
                        _buildTextBold('влажную ', context),
                        _buildTextDefault(
                          'кожу. ',
                          context,
                        ),
                        _buildTextHint(
                            'Это позволит улучшить связь датчика с вашим сердцем.',
                            context)
                      ],
                    ),
                    presetFontSizes: presetFontSizes,
                    textAlign: TextAlign.center,
                  ),
                  _buildDivider(),
                  AutoSizeText.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        _buildTextDefault(
                          'Крепление датчика осуществляется на ',
                          context,
                        ),
                        _buildTextBold('нагрудный ремешок.', context),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    presetFontSizes: presetFontSizes,
                  ),
                  _buildDivider(),
                  AutoSizeText.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        _buildTextDefault(
                          'Ремешок крепится на вашей ',
                          context,
                        ),
                        _buildTextBold('груди ', context),
                        _buildTextDefault(
                          'под грудными мышцами.',
                          context,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    presetFontSizes: presetFontSizes,
                  ),
                  _buildDivider(),
                  AutoSizeText.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        _buildTextDefault(
                          'Датчик активируется и будет ',
                          context,
                        ),
                        _buildTextBold('доступен ', context),
                        _buildTextDefault(
                          'после обнаружения вашего сердцебиения.',
                          context,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    presetFontSizes: presetFontSizes,
                  ),
                  _buildDivider(),
                  AutoSizeText.rich(
                    TextSpan(
                      children: <TextSpan>[
                        _buildTextDefault(
                          'После использования датчика не забывайте его ',
                          context,
                        ),
                        _buildTextBold('снимать ', context),
                        _buildTextDefault('с нагрудного ремешка, ', context),
                        _buildTextHint('что бы экономить батарею.', context),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    presetFontSizes: presetFontSizes,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: Get.width * 0.25,
                    child: BaseButton(
                      child: const BaseButtonText('Понятно'),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: Get.width * 0.15),
      ),
    );
  }

  TextSpan _buildTextBold(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextSpan _buildTextHint(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Theme.of(context).hintColor),
    );
  }

  TextSpan _buildTextDefault(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Widget _buildDivider() {
    return BaseDivider().paddingSymmetric(horizontal: Get.width * 0.15);
  }

  List<double> getTextSizeAdaptive() {
    if (isMobile) {
      return [14];
    } else if (isTable) {
      return [18];
    } else {
      return [0];
    }
  }
}
