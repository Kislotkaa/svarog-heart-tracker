part of 'history_detail_bloc.dart';

class HistoryDetailState extends Equatable {
  final StateStatus status;
  final UserModel? user;
  final List<UserHistoryModel> listHistory;
  final DeviceController? deviceController;
  final String? errorMessage;
  final String? errorTitle;

  const HistoryDetailState.initial() : this._();

  const HistoryDetailState._({
    this.status = StateStatus.initial,
    this.user,
    this.deviceController,
    this.listHistory = const [],
    this.errorMessage,
    this.errorTitle,
  });

  HistoryDetailState copyWith({
    StateStatus? status,
    UserModel? user,
    DeviceController? deviceController,
    List<UserHistoryModel>? listHistory,
    String? errorMessage,
    String? errorTitle,
  }) =>
      HistoryDetailState._(
        status: status ?? this.status,
        user: user ?? this.user,
        deviceController: deviceController ?? this.deviceController,
        listHistory: listHistory ?? this.listHistory,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  HistoryDetailState setToDefault() => const HistoryDetailState.initial();

  @override
  List<Object?> get props => [
        status,
        user,
        deviceController,
        listHistory,
        errorMessage,
        errorTitle,
      ];
}
