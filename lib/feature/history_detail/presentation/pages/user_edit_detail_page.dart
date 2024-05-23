import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_bar/base_app_bar_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/app_snackbar.dart';
import 'package:svarog_heart_tracker/core/ui_kit/base_text_field_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/button/base_button_widget.dart';
import 'package:svarog_heart_tracker/core/ui_kit/loading/base_linear_progress_indicator.dart';
import 'package:svarog_heart_tracker/core/ui_kit/toggle/base_toggle_widget.dart';
import 'package:svarog_heart_tracker/feature/history_detail/presentation/bloc/user_edit_detail/user_edit_detail_bloc.dart';
import 'package:svarog_heart_tracker/locator.dart';

@RoutePage()
class UserEditDetailPage extends StatefulWidget {
  final String userId;
  const UserEditDetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserEditDetailPage> createState() => _UserEditDetailPageState();
}

class _UserEditDetailPageState extends State<UserEditDetailPage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    sl<UserEditDetailBloc>().add(UserEditDetailInitialEvent(
      widget.userId,
      ageController: ageController,
      heightController: heightController,
      weightController: weightController,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserEditDetailBloc, UserEditDetailState>(
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
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBarWidget(
            title: 'Редактирование ${state.user?.personName}(а)',
            needClose: true,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Builder(
                  builder: (context) {
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      children: [
                        Text(
                          "Пол * ",
                          maxLines: 1,
                          style: appTheme.textTheme.smallCaptionSemibold12.copyWith(color: appTheme.textGrayColor),
                        ),
                        BaseToggle(
                          height: 50,
                          isActive: state.genderFlag,
                          slidersCallBack: [
                            (value) => sl<UserEditDetailBloc>().add(const UserEditDetailSetGenderEvent(0)),
                            (value) => sl<UserEditDetailBloc>().add(const UserEditDetailSetGenderEvent(1)),
                          ],
                          sliders: const [
                            'Женский',
                            'Мужской',
                          ],
                          sliderStyle: ToggleSliderStyle(
                            borderRadius: 12,
                            backgroundColor: appTheme.revertBasicColor,
                            textStyleActive: appTheme.textTheme.captionSemibold14.copyWith(
                              color: appTheme.revertTextColor,
                              fontWeight: FontWeight.w800,
                            ),
                            textStyleInActive: appTheme.textTheme.captionSemibold14.copyWith(
                              color: appTheme.textColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          containerStyle: ToggleContainerStyle(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(4),
                            backgroundColor: appTheme.grayColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        BaseTextFieldWidget(
                          title: 'Возраст *',
                          controller: ageController,
                          hintText: 'Ваш возраст...',
                          type: TextInputType.number,
                          mask: [
                            MaskTextInputFormatter(
                              mask: '###',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.eager,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: BaseTextFieldWidget(
                                title: 'Рост см *',
                                hintText: 'Ваш рост...',
                                controller: heightController,
                                maxLines: 1,
                                type: TextInputType.number,
                                mask: [
                                  MaskTextInputFormatter(
                                    mask: '###',
                                    filter: {"#": RegExp(r'[0-9]')},
                                    type: MaskAutoCompletionType.eager,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: BaseTextFieldWidget(
                                title: 'Вес кг*',
                                hintText: 'Ваш вес...',
                                controller: weightController,
                                mask: [
                                  MaskTextInputFormatter(
                                    mask: '###',
                                    filter: {"#": RegExp(r'[0-9]')},
                                    type: MaskAutoCompletionType.eager,
                                  ),
                                ],
                                maxLines: 1,
                                type: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BaseButtonWidget(
                    onPressed: () => sl<UserEditDetailBloc>().add(
                      UserEditDetailSaveEvent(
                        UserDetailParams(
                          gender: state.genderFlag,
                          age: int.tryParse(ageController.text),
                          height: double.tryParse(heightController.text),
                          weight: double.tryParse(weightController.text),
                        ),
                      ),
                    ),
                    margin: const EdgeInsets.all(16),
                    child: Text(
                      'Сохранить',
                      style: appTheme.textTheme.bodySemibold16.copyWith(color: appTheme.revertTextColor),
                    ),
                  ),
                ),
                if (state.status == StateStatus.loading)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: BaseLinearProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
