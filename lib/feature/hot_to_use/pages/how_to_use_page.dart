import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/common/assets.gen.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_button.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_divider.dart';
import 'package:svarog_heart_tracker/core/utils/screen_size.dart';

@RoutePage()
class HowToUsePage extends StatelessWidget {
  const HowToUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double>? presetFontSizes = [0];
    presetFontSizes = getTextSizeAdaptive(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
          child: Column(
            children: [
              if (!ScreenSize.isMobile(context)) SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              Expanded(
                flex: 9,
                child: Assets.icons.body.svg(),
              ),
              if (!ScreenSize.isMobile(context)) SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              Expanded(
                flex: 13,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText.rich(
                      TextSpan(
                        style: appTheme.textTheme.captionSemibold14,
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
                          _buildTextHint('Это позволит улучшить связь датчика с вашим сердцем.', context)
                        ],
                      ),
                      presetFontSizes: presetFontSizes,
                      textAlign: TextAlign.center,
                    ),
                    BaseDivider(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15)),
                    AutoSizeText.rich(
                      TextSpan(
                        style: appTheme.textTheme.captionSemibold14,
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
                    BaseDivider(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15)),
                    AutoSizeText.rich(
                      TextSpan(
                        style: appTheme.textTheme.captionSemibold14,
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
                    BaseDivider(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15)),
                    AutoSizeText.rich(
                      TextSpan(
                        style: appTheme.textTheme.captionSemibold14,
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
                    BaseDivider(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15)),
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
                    if (!ScreenSize.isMobile(context)) SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: BaseButton(
                        child: Text(
                          'Понятно',
                          style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.revertTextColor),
                        ),
                        onPressed: () => router.removeLast(),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _buildTextBold(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: appTheme.textTheme.captionSemibold14.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextSpan _buildTextHint(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: appTheme.textTheme.captionSemibold14.copyWith(color: Theme.of(context).hintColor),
    );
  }

  TextSpan _buildTextDefault(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: appTheme.textTheme.captionSemibold14,
    );
  }

  List<double> getTextSizeAdaptive(BuildContext context) {
    if (ScreenSize.isMobile(context)) {
      return [14];
    }
    return [18];
  }
}
