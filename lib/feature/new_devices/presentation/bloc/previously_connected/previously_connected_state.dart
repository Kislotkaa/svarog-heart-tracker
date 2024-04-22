part of 'previously_connected_bloc.dart';

class PreviouslyConnectedState extends Equatable {
  final StateStatus status;
  final List<UserModel> previouslyConnected;
  final String? errorMessage;
  final String? errorTitle;

  const PreviouslyConnectedState.initial() : this._();

  const PreviouslyConnectedState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.previouslyConnected = const [],
    this.errorTitle,
  });

  PreviouslyConnectedState copyWith({
    StateStatus? status,
    List<UserModel>? previouslyConnected,
    String? errorMessage,
    String? errorTitle,
  }) =>
      PreviouslyConnectedState._(
        status: status ?? this.status,
        previouslyConnected: previouslyConnected ?? this.previouslyConnected,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  PreviouslyConnectedState setToDefault() => const PreviouslyConnectedState.initial();

  @override
  List<Object?> get props => [
        status,
        previouslyConnected,
        errorMessage,
        errorTitle,
      ];
}
