part of 'history_detail_bloc.dart';

class HistoryDetailState extends Equatable {
  final StateStatus status;
  final UserModel? user;
  final UserDetailModel? detail;
  final HivePagination? pagination;
  final List<UserHistoryModel> listHistory;
  final String? errorMessage;
  final String? errorTitle;

  const HistoryDetailState.initial() : this._();

  const HistoryDetailState._({
    this.status = StateStatus.initial,
    this.user,
    this.detail,
    this.pagination,
    this.listHistory = const [],
    this.errorMessage,
    this.errorTitle,
  });

  HistoryDetailState copyWith({
    StateStatus? status,
    UserModel? user,
    UserDetailModel? detail,
    HivePagination? pagination,
    List<UserHistoryModel>? listHistory,
    String? errorMessage,
    String? errorTitle,
  }) =>
      HistoryDetailState._(
        status: status ?? this.status,
        user: user ?? this.user,
        detail: detail ?? this.detail,
        pagination: pagination ?? this.pagination,
        listHistory: listHistory ?? this.listHistory,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  HistoryDetailState setToDefault() => const HistoryDetailState.initial();

  @override
  List<Object?> get props => [
        status,
        user,
        detail,
        pagination,
        listHistory,
        errorMessage,
        errorTitle,
      ];
}
