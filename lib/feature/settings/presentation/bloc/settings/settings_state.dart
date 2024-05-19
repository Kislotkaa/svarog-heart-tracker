part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;

  const SettingsState.initial() : this._();

  const SettingsState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.errorTitle,
  });

  SettingsState copyWith({
    StateStatus? status,
    String? errorMessage,
    String? errorTitle,
  }) =>
      SettingsState._(
        status: status ?? this.status,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  SettingsState setToDefault() => const SettingsState.initial();

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        errorTitle,
      ];
}
