part of 'home_bloc.dart';

class HomeState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;
  final List<DeviceController> list;

  const HomeState.initial() : this._();

  const HomeState._({
    this.status = StateStatus.initial,
    this.list = const [],
    this.errorMessage,
    this.errorTitle,
  });

  HomeState copyWith({
    StateStatus? status,
    List<DeviceController>? list,
    String? errorMessage,
    String? errorTitle,
  }) =>
      HomeState._(
        status: status ?? this.status,
        list: list ?? this.list,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  HomeState setToDefault() => const HomeState.initial();

  @override
  List<Object?> get props => [
        status,
        list,
        errorMessage,
        errorTitle,
      ];
}
