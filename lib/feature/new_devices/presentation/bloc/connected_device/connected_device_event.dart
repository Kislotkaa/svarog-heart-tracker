part of 'connected_device_bloc.dart';

abstract class ConnectedDeviceEvent extends Equatable {
  const ConnectedDeviceEvent();

  @override
  List<Object?> get props => [];
}

class ConnectedDeviceInitialEvent extends ConnectedDeviceEvent {
  const ConnectedDeviceInitialEvent();
}

class ConnectedDeviceDisposeEvent extends ConnectedDeviceEvent {
  const ConnectedDeviceDisposeEvent();
}

class ConnectedDeviceSetScanResultEvent extends ConnectedDeviceEvent {
  final List<NewDeviceModel> connectedDevices;
  const ConnectedDeviceSetScanResultEvent({required this.connectedDevices});
}
