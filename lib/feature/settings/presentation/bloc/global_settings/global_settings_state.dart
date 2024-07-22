part of 'global_settings_bloc.dart';

class GlobalSettingsState extends Equatable {
  final StateStatus status;
  final GlobalSettingsModel? globalSettingsModel;
  final String? errorMessage;
  final String? errorTitle;

  const GlobalSettingsState.initial() : this._();

  const GlobalSettingsState._({
    this.status = StateStatus.initial,
    this.globalSettingsModel,
    this.errorMessage,
    this.errorTitle,
  });

  GlobalSettingsState copyWith({
    StateStatus? status,
    GlobalSettingsModel? globalSettingsModel,
    String? errorMessage,
    String? errorTitle,
  }) =>
      GlobalSettingsState._(
        status: status ?? this.status,
        globalSettingsModel: globalSettingsModel ?? this.globalSettingsModel,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  GlobalSettingsState setToDefault() => const GlobalSettingsState.initial();

  @override
  List<Object?> get props => [
        status,
        globalSettingsModel,
        errorMessage,
        errorTitle,
      ];
}
