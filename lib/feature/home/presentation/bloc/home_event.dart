part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {
  const HomeInitialEvent();
}

class HomeRefreshEvent extends HomeEvent {
  const HomeRefreshEvent();
}

class HomAddDeviceControllerEvent extends HomeEvent {
  final DeviceController deviceController;
  const HomAddDeviceControllerEvent({required this.deviceController});
}

class HomRemoveDeviceControllerEvent extends HomeEvent {
  final BluetoothDevice blueDevice;
  const HomRemoveDeviceControllerEvent({required this.blueDevice});
}

class HomeDisconnectDeviceEvent extends HomeEvent {
  final BluetoothDevice device;
  const HomeDisconnectDeviceEvent({required this.device});
}
