part of 'new_device_bloc.dart';

abstract class NewDeviceEvent extends Equatable {
  const NewDeviceEvent();

  @override
  List<Object?> get props => [];
}

class NewDeviceRefreshEvent extends NewDeviceEvent {
  const NewDeviceRefreshEvent();
}

class NewDeviceScanEvent extends NewDeviceEvent {
  const NewDeviceScanEvent();
}

class NewDeviceConnectOrDisconnectEvent extends NewDeviceEvent {
  final BluetoothDevice device;
  const NewDeviceConnectOrDisconnectEvent({required this.device});
}
