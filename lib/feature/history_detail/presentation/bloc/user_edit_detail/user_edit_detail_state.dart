part of 'user_edit_detail_bloc.dart';

class UserEditDetailState extends Equatable {
  final StateStatus status;
  final int genderFlag;
  final UserModel? user;
  final UserDetailModel? detail;
  final String? errorMessage;
  final String? errorTitle;

  const UserEditDetailState.initial() : this._();

  const UserEditDetailState._({
    this.status = StateStatus.initial,
    this.user,
    this.genderFlag = 1,
    this.detail,
    this.errorMessage,
    this.errorTitle,
  });

  UserEditDetailState copyWith({
    StateStatus? status,
    UserModel? user,
    int? genderFlag,
    UserDetailModel? detail,
    String? errorMessage,
    String? errorTitle,
  }) =>
      UserEditDetailState._(
        status: status ?? this.status,
        user: user ?? this.user,
        genderFlag: genderFlag ?? this.genderFlag,
        detail: detail ?? this.detail,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  UserEditDetailState setToDefault() => const UserEditDetailState.initial();

  @override
  List<Object?> get props => [
        status,
        user,
        genderFlag,
        detail,
        errorMessage,
        errorTitle,
      ];
}
