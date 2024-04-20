part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;
  const AuthState.initial() : this._();

  const AuthState._({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.errorTitle,
  });

  AuthState copyWith({
    StateStatus? status,
    String? errorMessage,
    String? errorTitle,
  }) =>
      AuthState._(
        status: status ?? this.status,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  AuthState setToDefault() => const AuthState.initial();

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        errorTitle,
      ];
}
