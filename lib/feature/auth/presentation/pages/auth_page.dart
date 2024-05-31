import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/config/env.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_button_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_text_field_widget.dart';
import 'package:svarog_heart_tracker/core/utils/lounch_url.dart';
import 'package:svarog_heart_tracker/core/utils/screen_size.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/widgets/auth_animated_logo.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController password = TextEditingController();

  final focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, next) => prev.status != next.status,
        listener: (BuildContext context, AuthState state) {
          if (state.errorTitle != null) {
            AppSnackbar.showTextFloatingSnackBar(
              title: state.errorTitle ?? '',
              description: state.errorMessage ?? '',
              overlayState: Overlay.of(context),
              status: SnackStatusEnum.warning,
            );
          }
        },
        buildWhen: (prev, next) => prev.status != next.status,
        builder: (context, state) {
          return SafeArea(
            child: Container(
              width: ScreenSize.isMobile(context) ? double.infinity : MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Column(
                    children: [
                      AuthAnimatedLogo(focusNode: focusNode),
                      const SizedBox(height: 8),
                      Text(
                        'Сварог',
                        style: TextStyle(fontSize: 24, color: appTheme.textColor),
                      ),
                    ],
                  ),
                  const SizedBox.shrink(),
                  BaseTextFieldWidget(
                    focusNode: focusNode,
                    height: 60,
                    controller: password,
                    titleCenter: true,
                    title: 'Пароль',
                    autocorrect: false,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    backgroundColor: appTheme.cardColor,
                    onEditingComplete: () {
                      TextInput.finishAutofillContext();
                    },
                  ),
                  const SizedBox.shrink(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BaseButtonWidget(
                        margin: const EdgeInsets.only(bottom: 8),
                        onPressed: () {
                          sl<AuthBloc>().add(AuthSingInEvent(password: password.text));
                        },
                        child: Text(
                          'Войти',
                          style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.revertTextColor),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => goToUrl(EnvironmentConfig.APP_POLIT_URL),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              _buildTextDefault(
                                'Авторизируясь в приложении вы соглашаетесь с ',
                                context,
                              ),
                              _buildTextLink(
                                'настоящей политикой конфиденциальности.',
                                context,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextSpan _buildTextDefault(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: appTheme.textTheme.smallCaptionSemibold12,
    );
  }

  TextSpan _buildTextLink(String text, BuildContext context) {
    return TextSpan(
      text: text,
      style: appTheme.textTheme.smallCaptionSemibold12.copyWith(
        color: appTheme.blueColor,
      ),
    );
  }
}
