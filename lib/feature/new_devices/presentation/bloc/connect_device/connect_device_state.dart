part of 'connect_device_bloc.dart';

class ConnectDeviceState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;

  const ConnectDeviceState.initial() : this._();

  const ConnectDeviceState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.errorTitle,
  });

  ConnectDeviceState copyWith({
    StateStatus? status,
    String? errorMessage,
    String? errorTitle,
  }) =>
      ConnectDeviceState._(
        status: status ?? this.status,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  ConnectDeviceState setToDefault() => const ConnectDeviceState.initial();

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        errorTitle,
      ];
}
