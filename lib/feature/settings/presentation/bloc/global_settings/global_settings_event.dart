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
  final double? timeSavedData;
  final double? timeDisconnect;
  final double? timeCheckDevice;

  const GlobalSettingsUpdateEvent({this.timeSavedData, this.timeDisconnect, this.timeCheckDevice});
}
