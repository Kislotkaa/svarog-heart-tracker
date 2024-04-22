part of 'scan_device_bloc.dart';

abstract class ScanDeviceEvent extends Equatable {
  const ScanDeviceEvent();

  @override
  List<Object?> get props => [];
}

class ScanDeviceInitialEvent extends ScanDeviceEvent {
  const ScanDeviceInitialEvent();
}

class ScanDeviceSetScanResultEvent extends ScanDeviceEvent {
  final List<NewDeviceModel> scanResult;
  final String textStatus;
  const ScanDeviceSetScanResultEvent({required this.scanResult, required this.textStatus});
}

class ScanDeviceDisposeEvent extends ScanDeviceEvent {
  const ScanDeviceDisposeEvent();
}
