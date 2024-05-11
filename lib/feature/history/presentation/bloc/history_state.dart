part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final StateStatus status;
  final List<UserModel> users;
  final String? errorMessage;
  final String? errorTitle;

  const HistoryState.initial() : this._();

  const HistoryState._({
    this.status = StateStatus.initial,
    this.users = const [],
    this.errorMessage,
    this.errorTitle,
  });

  HistoryState copyWith({
    StateStatus? status,
    List<UserModel>? users,
    String? errorMessage,
    String? errorTitle,
  }) =>
      HistoryState._(
        status: status ?? this.status,
        users: users ?? this.users,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  HistoryState setToDefault() => const HistoryState.initial();

  @override
  List<Object?> get props => [
        status,
        users,
        errorMessage,
        errorTitle,
      ];
}
