part of 'new_device_bloc.dart';

class NewDeviceState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;

  const NewDeviceState.initial() : this._();

  const NewDeviceState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.errorTitle,
  });

  NewDeviceState copyWith({
    StateStatus? status,
    String? errorMessage,
    String? errorTitle,
  }) =>
      NewDeviceState._(
        status: status ?? this.status,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  NewDeviceState setToDefault() => const NewDeviceState.initial();

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        errorTitle,
      ];
}
