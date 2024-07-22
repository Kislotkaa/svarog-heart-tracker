import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/update_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/get_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/insert_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/get_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_settings/insert_user_settings_by_pk.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:uuid/uuid.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  /// **[String]** required
  final GetUserByPkUseCase getUserByPkUseCase;

  /// **[String]** required
  final GetUserDetailByPkUseCase getUserDetailByPkUseCase;

  /// **[String]** required
  final GetUserSettingsByPkUseCase getUserSettingsByPkUseCase;

  /// **[UserParams]** required
  final UpdateUserByPkUseCase updateUserByPkUseCase;

  /// **[UserDetailModel]** required
  final InsertUserDetailByPkUseCase insertUserDetailByPkUseCase;

  /// **[UserSettingsModel]** required
  final InsertUserSettingsByPkUseCase insertUserSettingsByPkUseCase;

  UserEditBloc({
    required this.getUserByPkUseCase,
    required this.getUserDetailByPkUseCase,
    required this.getUserSettingsByPkUseCase,
    required this.updateUserByPkUseCase,
    required this.insertUserDetailByPkUseCase,
    required this.insertUserSettingsByPkUseCase,
  }) : super(const UserEditState.initial()) {
    on<UserEditInitialEvent>((event, emit) async {
      emit(state.copyWith(
        status: StateStatus.loading,
        errorMessage: null,
        errorTitle: null,
      ));

      final failurOrUser = await getUserByPkUseCase(event.userId);
      UserModel? user;

      failurOrUser.fold(
        (l) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorTitle: 'Ошибка',
              errorMessage: l.data?.message,
            ),
          );
          return;
        },
        (userResult) {
          user = userResult;
          emit(
            state.copyWith(
              status: StateStatus.success,
              user: userResult,
            ),
          );
        },
      );

      if (user?.userDetailId == null) {
        return;
      }

      final failurOrDetail = await getUserDetailByPkUseCase(user?.userDetailId ?? '');

      failurOrDetail.fold(
        (l) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorTitle: 'Ошибка',
              errorMessage: l.data?.message,
            ),
          );
          return;
        },
        (detailResult) {
          if (detailResult != null) {
            event.ageController.text = detailResult.age.toString();
            event.heightController.text = detailResult.height.toString();
            event.weightController.text = detailResult.weight.toString();
          }

          emit(
            state.copyWith(
              status: StateStatus.success,
              detail: detailResult,
            ),
          );
        },
      );

      final failurOrSettings = await getUserSettingsByPkUseCase(user?.userSettingsId ?? '');

      failurOrSettings.fold(
        (l) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorTitle: 'Ошибка',
              errorMessage: l.data?.message,
            ),
          );
          return;
        },
        (settingsResult) {
          if (settingsResult != null) {
            event.greenZoneController.text = settingsResult.greenZone.toString();
            event.orangeZoneController.text = settingsResult.orangeZone.toString();
          }
          emit(
            state.copyWith(
              status: StateStatus.success,
              settings: settingsResult,
            ),
          );
        },
      );
    });

    on<UserSaveGenderEvent>((event, emit) {
      emit(
        state.copyWith(
          status: StateStatus.success,
          genderFlag: event.genderFlag,
          errorTitle: null,
          errorMessage: null,
        ),
      );
    });

    on<UserSaveEvent>((event, emit) async {
      final UserModel? user = state.user;
      if (user == null) return;

      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorTitle: null,
          errorMessage: null,
        ),
      );

      if (event.detailParams.age == null) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Заполните возраст',
            errorMessage: 'Данные не могут быть не полными, для корректной работы, заполните поле Возраст *',
          ),
        );
        return;
      }
      if (event.detailParams.height == null) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Заполните рост',
            errorMessage: 'Данные не могут быть не полными, для корректной работы, заполните поле Рост *',
          ),
        );
        return;
      }
      if (event.detailParams.weight == null) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Заполните вес',
            errorMessage: 'Данные не могут быть не полными, для корректной работы, заполните поле Вес *',
          ),
        );
        return;
      }

      if (event.settingsParams.greenZone >= event.settingsParams.orangeZone) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Не верные границы',
            errorMessage: 'Порог зелёной зоны, всегда должен быть меньше порога оранжевой',
          ),
        );
        return;
      }

      final userDetailModel = UserDetailModel(
        id: state.detail?.id ?? const Uuid().v4(),
        gender: event.detailParams.gender,
        age: event.detailParams.age ?? state.detail?.age ?? 0,
        height: event.detailParams.height ?? state.detail?.height ?? 0,
        weight: event.detailParams.weight ?? state.detail?.weight ?? 0,
      );

      final failurOrDetail = await insertUserDetailByPkUseCase(userDetailModel);

      failurOrDetail.fold((l) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorTitle: 'Ошибка',
            errorMessage: l.data?.message,
          ),
        );
      }, (detailResult) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            detail: detailResult,
          ),
        );
      });

      final userSettingsModel = UserSettingsModel(
        id: state.settings?.id ?? const Uuid().v4(),
        greenZone: event.settingsParams.greenZone,
        orangeZone: event.settingsParams.orangeZone,
      );

      final failurOrSettings = await insertUserSettingsByPkUseCase(userSettingsModel);

      failurOrSettings.fold((l) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorTitle: 'Ошибка',
            errorMessage: l.data?.message,
          ),
        );
      }, (settingsResult) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            settings: settingsResult,
          ),
        );
      });

      final failurOrUser = await updateUserByPkUseCase(
        UserParams(
          id: user.id,
          userDetailId: userDetailModel.id,
          userSettingsId: userSettingsModel.id,
          personName: user.personName,
          deviceName: user.deviceName,
          isAutoConnect: user.isAutoConnect,
        ),
      );

      failurOrUser.fold((l) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorTitle: 'Ошибка',
            errorMessage: l.data?.message,
          ),
        );
        return;
      }, (userReturned) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            user: userReturned,
          ),
        );
      });

      router.removeLast();
    });
  }
}
