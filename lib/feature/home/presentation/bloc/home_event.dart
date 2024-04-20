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

class HomeDisconnectDeviceEvent extends HomeEvent {
  final BluetoothDevice device;
  const HomeDisconnectDeviceEvent({required this.device});
}
