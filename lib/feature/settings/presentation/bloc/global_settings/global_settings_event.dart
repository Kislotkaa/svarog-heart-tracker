part of 'global_settings_bloc.dart';

abstract class GlobalSettingsEvent extends Equatable {
  const GlobalSettingsEvent();

  @override
  List<Object?> get props => [];
}

class GlobalSettingsSetToDefaultEvent extends GlobalSettingsEvent {
  const GlobalSettingsSetToDefaultEvent();
}

class GlobalSettingsUpdateEvent extends GlobalSettingsEvent {
  final double? timeSavedData; // Время после которого сохраняются данные
  final double? timeDisconnect; // Время после которого происходит отключение
  const GlobalSettingsUpdateEvent({this.timeSavedData, this.timeDisconnect});
}
