part of 'auth_admin_bloc.dart';

class AuthAdminState extends Equatable {
  final StateStatus status;
  final CrossFadeState crossFadeState;
  final String? errorMessage;
  final String? errorTitle;

  const AuthAdminState.initial() : this._();

  const AuthAdminState._({
    this.status = StateStatus.initial,
    this.crossFadeState = CrossFadeState.showFirst,
    this.errorMessage,
    this.errorTitle,
  });

  AuthAdminState copyWith({
    StateStatus? status,
    TextEditingController? adminPassword,
    TextEditingController? authPassword,
    TextEditingController? authRepeatPassword,
    CrossFadeState? crossFadeState,
    String? errorMessage,
    String? errorTitle,
  }) =>
      AuthAdminState._(
        status: status ?? this.status,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
        crossFadeState: crossFadeState ?? this.crossFadeState,
      );

  AuthAdminState setToDefault() => const AuthAdminState.initial();

  @override
  List<Object?> get props => [
        status,
        crossFadeState,
        errorMessage,
        errorTitle,
      ];
}
