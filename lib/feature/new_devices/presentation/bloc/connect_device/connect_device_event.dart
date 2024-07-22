part of 'connect_device_bloc.dart';

abstract class ConnectDeviceEvent extends Equatable {
  const ConnectDeviceEvent();

  @override
  List<Object?> get props => [];
}

class ConnectDeviceDisconnectEvent extends ConnectDeviceEvent {
  final DeviceController? deviceController;
  final BluetoothDevice? blueDevice;

  const ConnectDeviceDisconnectEvent({this.deviceController, this.blueDevice});
}

class ConnectDeviceConnectEvent extends ConnectDeviceEvent {
  final BluetoothDevice device;
  final String name;
  const ConnectDeviceConnectEvent({required this.device, required this.name});
}
