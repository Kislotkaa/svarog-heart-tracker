part of 'home_bloc.dart';

class HomeState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;
  final List<DeviceController> list;
  final List<UserModel> users;

  const HomeState.initial() : this._();

  const HomeState._({
    this.status = StateStatus.initial,
    this.list = const [],
    this.users = const [],
    this.errorMessage,
    this.errorTitle,
  });

  HomeState copyWith({
    StateStatus? status,
    List<DeviceController>? list,
    List<UserModel>? users,
    String? errorMessage,
    String? errorTitle,
  }) =>
      HomeState._(
        status: status ?? this.status,
        list: list ?? this.list,
        users: users ?? this.users,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  HomeState setToDefault() => const HomeState.initial();

  @override
  List<Object?> get props => [
        status,
        list,
        users,
        errorMessage,
        errorTitle,
      ];
}
