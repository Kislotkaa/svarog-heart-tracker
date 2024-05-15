part of 'user_settings_bloc.dart';

class UserSettingsState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;

  const UserSettingsState.initial() : this._();

  const UserSettingsState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.errorTitle,
  });

  UserSettingsState copyWith({
    StateStatus? status,
    String? errorMessage,
    String? errorTitle,
  }) =>
      UserSettingsState._(
        status: status ?? this.status,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  UserSettingsState setToDefault() => const UserSettingsState.initial();

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        errorTitle,
      ];
}
