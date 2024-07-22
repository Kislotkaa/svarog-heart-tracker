part of 'scan_device_bloc.dart';

class ScanDeviceState extends Equatable {
  final StateStatus status;
  final List<NewDeviceModel> scanResult;
  final String textStatus;
  final String? errorMessage;
  final String? errorTitle;

  const ScanDeviceState.initial() : this._();

  const ScanDeviceState._({
    this.status = StateStatus.initial,
    this.scanResult = const [],
    this.textStatus = 'Поиск свободных устройств...',
    this.errorMessage,
    this.errorTitle,
  });

  ScanDeviceState copyWith({
    StateStatus? status,
    List<NewDeviceModel>? scanResult,
    String? textStatus,
    String? errorMessage,
    String? errorTitle,
  }) =>
      ScanDeviceState._(
        status: status ?? this.status,
        scanResult: scanResult ?? this.scanResult,
        textStatus: textStatus ?? this.textStatus,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  ScanDeviceState setToDefault() => const ScanDeviceState.initial();

  @override
  List<Object?> get props => [
        status,
        scanResult,
        errorMessage,
        errorTitle,
      ];
}
