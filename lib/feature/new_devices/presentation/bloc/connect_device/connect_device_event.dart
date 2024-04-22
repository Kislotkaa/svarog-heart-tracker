part of 'connect_device_bloc.dart';

abstract class ConnectDeviceEvent extends Equatable {
  const ConnectDeviceEvent();

  @override
  List<Object?> get props => [];
}

class ConnectDeviceDisconnectEvent extends ConnectDeviceEvent {
  final BluetoothDevice device;
  const ConnectDeviceDisconnectEvent({required this.device});
}

class ConnectDeviceConnectEvent extends ConnectDeviceEvent {
  final BluetoothDevice device;
  final String name;
  const ConnectDeviceConnectEvent({required this.device, required this.name});
}

class ConnectDeviceConnectOrDisconnectEvent extends ConnectDeviceEvent {
  final BluetoothDevice device;
  const ConnectDeviceConnectOrDisconnectEvent({required this.device});
}
