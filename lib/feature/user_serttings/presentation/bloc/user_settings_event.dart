part of 'user_settings_bloc.dart';

abstract class UserSettingsEvent extends Equatable {
  const UserSettingsEvent();

  @override
  List<Object?> get props => [];
}

class UserSettingsInitEvent extends UserSettingsEvent {
  const UserSettingsInitEvent();
}

class SetUserSettingsEvent extends UserSettingsEvent {
  const SetUserSettingsEvent();
}
