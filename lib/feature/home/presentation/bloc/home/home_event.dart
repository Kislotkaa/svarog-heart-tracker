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

class HomeAddDeviceControllerEvent extends HomeEvent {
  final DeviceController deviceController;
  const HomeAddDeviceControllerEvent({required this.deviceController});
}

class HomeRemoveDeviceEvent extends HomeEvent {
  final BluetoothDevice blueDevice;

  const HomeRemoveDeviceEvent({required this.blueDevice});
}
