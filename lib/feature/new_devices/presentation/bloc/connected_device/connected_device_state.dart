part of 'connected_device_bloc.dart';

class ConnectedDeviceState extends Equatable {
  final StateStatus status;
  final List<NewDeviceModel> connectedDevices;
  final String? errorMessage;
  final String? errorTitle;

  const ConnectedDeviceState.initial() : this._();

  const ConnectedDeviceState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.connectedDevices = const [],
    this.errorTitle,
  });

  ConnectedDeviceState copyWith({
    StateStatus? status,
    List<NewDeviceModel>? connectedDevices,
    String? errorMessage,
    String? errorTitle,
  }) =>
      ConnectedDeviceState._(
        status: status ?? this.status,
        connectedDevices: connectedDevices ?? this.connectedDevices,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  ConnectedDeviceState setToDefault() => const ConnectedDeviceState.initial();

  @override
  List<Object?> get props => [
        status,
        connectedDevices,
        errorMessage,
        errorTitle,
      ];
}
