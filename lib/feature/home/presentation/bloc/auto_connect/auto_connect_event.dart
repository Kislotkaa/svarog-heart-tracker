part of 'auto_connect_bloc.dart';

abstract class AutoConnectEvent extends Equatable {
  const AutoConnectEvent();

  @override
  List<Object?> get props => [];
}

class AutoConnectInitialEvent extends AutoConnectEvent {
  const AutoConnectInitialEvent();
}

class AutoConnectDisposeEvent extends AutoConnectEvent {
  const AutoConnectDisposeEvent();
}

class AutoConnectSetScanResultEvent extends AutoConnectEvent {
  final List<ScanResult> scanResult;
  const AutoConnectSetScanResultEvent(this.scanResult);
}

class AutoConnectConnectEvent extends AutoConnectEvent {
  final BluetoothDevice blueDevice;
  final String name;

  const AutoConnectConnectEvent(this.blueDevice, this.name);
}
