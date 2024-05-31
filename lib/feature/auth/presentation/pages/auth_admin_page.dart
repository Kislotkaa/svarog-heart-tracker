import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/config/env.dart';
import 'package:svarog_heart_tracker/core/theme/utils/duration.dart';
import 'package:svarog_heart_tracker/core/service/theme/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_button_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_text_field_widget.dart';
import 'package:svarog_heart_tracker/core/utils/screen_size.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/bloc/auth_admin/auth_admin_bloc.dart';
import 'package:svarog_heart_tracker/feature/auth/presentation/widgets/auth_animated_logo.dart';

@RoutePage()
class AuthAdminPage extends StatefulWidget {
  const AuthAdminPage({Key? key}) : super(key: key);

  @override
  State<AuthAdminPage> createState() => _AuthAdminPageState();
}

class _AuthAdminPageState extends State<AuthAdminPage> {
  final TextEditingController adminPassword = TextEditingController();
  final TextEditingController authPassword = TextEditingController();
  final TextEditingController authRepeatPassword = TextEditingController();

  final focusNode = FocusNode();

  @override
  void initState() {
    if (kDebugMode) adminPassword.text = EnvironmentConfig.APP_PASSWORD;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appTheme.alwaysBlackColor,
      body: BlocConsumer<AuthAdminBloc, AuthAdminState>(
        listenWhen: (prev, next) => prev.status != next.status,
        listener: (context, state) {
          if (state.errorTitle != null) {
            AppSnackbar.showTextFloatingSnackBar(
              title: state.errorTitle ?? '',
              description: state.errorMessage ?? '',
              overlayState: Overlay.of(context),
              status: SnackStatusEnum.warning,
            );
          }
        },
        buildWhen: (prev, next) => prev.crossFadeState != next.crossFadeState,
        builder: (context, state) {
          final authAdminBloc = context.read<AuthAdminBloc>();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedCrossFade(
                firstChild: Center(
                  child: SizedBox(
                    width: ScreenSize.isMobile(context) ? null : MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Column(
                          children: [
                            AuthAnimatedLogo(focusNode: focusNode),
                            const SizedBox(height: 8),
                            Text(
                              'Администратор',
                              style: TextStyle(fontSize: 24, color: appTheme.alwaysWhiteTextColor),
                            ),
                          ],
                        ),
                        BaseTextFieldWidget(
                          focusNode: focusNode,
                          controller: adminPassword,
                          titleCenter: true,
                          title: 'Пароль администратора',
                          obscureText: true,
                          autocorrect: false,
                          textAlign: TextAlign.center,
                          backgroundColor: appTheme.alwaysWhiteColor,
                          style: appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.alwaysBlackTextColor),
                          cursorColor: appTheme.alwaysBlackTextColor,
                          textCapitalization: TextCapitalization.none,
                          onEditingComplete: () {
                            TextInput.finishAutofillContext();
                          },
                          onSaved: (s) => FocusScope.of(context).unfocus(),
                        ),
                        const SizedBox.shrink(),
                        BaseButtonWidget(
                          color: appTheme.alwaysWhiteColor,
                          visualFeedBack: false,
                          phisicalFeedBack: true,
                          onPressed: () => authAdminBloc.add(AuthSingInAdminEvent(password: adminPassword.text)),
                          child: Text(
                            'Войти',
                            style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.alwaysBlackTextColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                secondChild: Center(
                  child: SizedBox(
                    width: ScreenSize.isMobile(context) ? double.infinity : MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Column(
                          children: [
                            BaseTextFieldWidget(
                              controller: authPassword,
                              titleCenter: true,
                              title: 'Пароль',
                              style:
                                  appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.alwaysBlackTextColor),
                              cursorColor: appTheme.alwaysBlackTextColor,
                              textCapitalization: TextCapitalization.none,
                              backgroundColor: appTheme.alwaysWhiteColor,
                              autocorrect: false,
                              textAlign: TextAlign.center,
                              onEditingComplete: () {
                                TextInput.finishAutofillContext();
                              },
                              onSaved: (s) => FocusScope.of(context).unfocus(),
                            ),
                            const SizedBox(height: 16),
                            BaseTextFieldWidget(
                              controller: authRepeatPassword,
                              titleCenter: true,
                              title: 'Повторите пароль',
                              style:
                                  appTheme.textTheme.captionSemibold14.copyWith(color: appTheme.alwaysBlackTextColor),
                              cursorColor: appTheme.alwaysBlackTextColor,
                              textCapitalization: TextCapitalization.none,
                              backgroundColor: appTheme.alwaysWhiteColor,
                              autocorrect: false,
                              textAlign: TextAlign.center,
                              onEditingComplete: () {
                                TextInput.finishAutofillContext();
                              },
                              onSaved: (s) => FocusScope.of(context).unfocus(),
                            ),
                          ],
                        ),
                        BaseButtonWidget(
                          color: appTheme.alwaysWhiteColor,
                          visualFeedBack: false,
                          phisicalFeedBack: true,
                          onPressed: () => authAdminBloc.add(
                            AuthSetPasswordAdminEvent(
                              password: authPassword.text,
                              repeatPassword: authRepeatPassword.text,
                            ),
                          ),
                          child: Text(
                            'Установить',
                            style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.alwaysBlackTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                crossFadeState: state.crossFadeState,
                duration: AppDuration.medium,
              ),
            ),
          );
        },
      ),
    );
  }
}
