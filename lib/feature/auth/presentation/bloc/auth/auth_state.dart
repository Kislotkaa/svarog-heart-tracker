part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final StateStatus status;
  final bool hasFocus;
  final CrossFadeState crossFadeState;
  final String? errorMessage;
  final String? errorTitle;

  const AuthState.initial() : this._();

  const AuthState._({
    this.status = StateStatus.initial,
    this.hasFocus = false,
    this.crossFadeState = CrossFadeState.showFirst,
    this.errorMessage,
    this.errorTitle,
  });

  AuthState copyWith({
    StateStatus? status,
    bool? hasFocus,
    TextEditingController? adminPassword,
    TextEditingController? authPassword,
    TextEditingController? authRepeatPassword,
    CrossFadeState? crossFadeState,
    String? errorMessage,
    String? errorTitle,
  }) =>
      AuthState._(
        status: status ?? this.status,
        hasFocus: hasFocus ?? this.hasFocus,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
        crossFadeState: crossFadeState ?? this.crossFadeState,
      );

  AuthState setToDefault() => const AuthState.initial();

  @override
  List<Object?> get props => [
        status,
        hasFocus,
        crossFadeState,
        errorMessage,
        errorTitle,
      ];
}
