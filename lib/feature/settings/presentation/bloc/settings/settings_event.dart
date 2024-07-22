part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLogoutEvent extends SettingsEvent {
  const SettingsLogoutEvent();
}

class SettingsDeleteAccountEvent extends SettingsEvent {
  const SettingsDeleteAccountEvent();
}

class SettingsDeleteHistoryEvent extends SettingsEvent {
  const SettingsDeleteHistoryEvent();
}
