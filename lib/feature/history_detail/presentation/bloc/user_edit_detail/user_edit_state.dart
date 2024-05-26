part of 'user_edit_bloc.dart';

class UserEditState extends Equatable {
  final StateStatus status;
  final int genderFlag;
  final UserModel? user;
  final UserDetailModel? detail;
  final UserSettingsModel? settings;
  final String? errorMessage;
  final String? errorTitle;

  const UserEditState.initial() : this._();

  const UserEditState._({
    this.status = StateStatus.initial,
    this.user,
    this.genderFlag = 1,
    this.detail,
    this.settings,
    this.errorMessage,
    this.errorTitle,
  });

  UserEditState copyWith({
    StateStatus? status,
    UserModel? user,
    int? genderFlag,
    UserDetailModel? detail,
    UserSettingsModel? settings,
    String? errorMessage,
    String? errorTitle,
  }) =>
      UserEditState._(
        status: status ?? this.status,
        user: user ?? this.user,
        genderFlag: genderFlag ?? this.genderFlag,
        detail: detail ?? this.detail,
        settings: settings ?? this.settings,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  UserEditState setToDefault() => const UserEditState.initial();

  @override
  List<Object?> get props => [
        status,
        user,
        genderFlag,
        detail,
        settings,
        errorMessage,
        errorTitle,
      ];
}
