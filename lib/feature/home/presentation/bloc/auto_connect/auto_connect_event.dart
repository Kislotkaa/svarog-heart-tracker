part of 'auto_connect_bloc.dart';

abstract class AutoConnectEvent extends Equatable {
  const AutoConnectEvent();

  @override
  List<Object?> get props => [];
}

class AutoConnectDisposeEvent extends AutoConnectEvent {
  const AutoConnectDisposeEvent();
}

class AutoConnectSetScanResultEvent extends AutoConnectEvent {
  final List<ScanResult> scanResult;
  const AutoConnectSetScanResultEvent(this.scanResult);
}
