import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/user_detail_model.dart';
import 'package:svarog_heart_tracker/core/models/user_model.dart';
import 'package:svarog_heart_tracker/core/router/app_router.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/get_user_by_pk_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user/update_user_usecase.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/get_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/core/service/database/usecase/user_detail/insert_user_detail_by_pk.dart';
import 'package:svarog_heart_tracker/feature/home/data/user_params.dart';
import 'package:uuid/uuid.dart';

part 'user_edit_detail_event.dart';
part 'user_edit_detail_state.dart';

class UserEditDetailBloc extends Bloc<UserEditDetailEvent, UserEditDetailState> {
  /// **[String]** required
  final GetUserByPkUseCase getUserByPkUseCase;

  /// **[String]** required
  final GetUserDetailByPkUseCase getUserDetailByPkUseCase;

  /// **[UserParams]** required
  final UpdateUserByPkUseCase updateUserByPkUseCase;

  /// **[UserDetailModel]** required
  final InsertUserDetailByPkUseCase insertUserDetailByPkUseCase;

  UserEditDetailBloc({
    required this.getUserByPkUseCase,
    required this.getUserDetailByPkUseCase,
    required this.updateUserByPkUseCase,
    required this.insertUserDetailByPkUseCase,
  }) : super(const UserEditDetailState.initial()) {
    on<UserEditDetailInitialEvent>((event, emit) async {
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
    });

    on<UserEditDetailSetGenderEvent>((event, emit) {
      emit(
        state.copyWith(
          status: StateStatus.success,
          genderFlag: event.genderFlag,
          errorTitle: null,
          errorMessage: null,
        ),
      );
    });

    on<UserEditDetailSaveEvent>((event, emit) async {
      final UserModel? user = state.user;
      if (user == null) return;

      emit(
        state.copyWith(
          status: StateStatus.loading,
          errorTitle: null,
          errorMessage: null,
        ),
      );

      if (event.detailModel.age == null) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Заполните возраст',
            errorMessage: 'Данные не могут быть не полными, для корректной работы, заполните поле Возраст *',
          ),
        );
        return;
      }
      if (event.detailModel.height == null) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Заполните рост',
            errorMessage: 'Данные не могут быть не полными, для корректной работы, заполните поле Рост *',
          ),
        );
        return;
      }
      if (event.detailModel.weight == null) {
        emit(
          state.copyWith(
            status: StateStatus.notValid,
            errorTitle: 'Заполните вес',
            errorMessage: 'Данные не могут быть не полными, для корректной работы, заполните поле Вес *',
          ),
        );
        return;
      }

      final userDetailModel = UserDetailModel(
        id: const Uuid().v4(),
        gender: event.detailModel.gender,
        age: event.detailModel.age!,
        height: event.detailModel.height!,
        weight: event.detailModel.weight!,
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
        return;
      }, (detailResult) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            detail: detailResult,
          ),
        );
      });

      final failurOrUser = await updateUserByPkUseCase(
        UserParams(
          id: user.id,
          userDetailId: userDetailModel.id,
          userSettingsId: user.userSettingsId,
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
      }, (user) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            user: user,
          ),
        );
        router.removeLast();
      });
    });
  }
}
