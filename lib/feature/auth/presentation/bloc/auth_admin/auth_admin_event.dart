part of 'auth_admin_bloc.dart';

abstract class AuthAdminEvent extends Equatable {
  const AuthAdminEvent();

  @override
  List<Object?> get props => [];
}

class AuthSingInAdminEvent extends AuthAdminEvent {
  final String password;

  const AuthSingInAdminEvent({required this.password});
}

class AuthSingInEvent extends AuthAdminEvent {
  final String password;

  const AuthSingInEvent({required this.password});
}

class AuthSetPasswordAdminEvent extends AuthAdminEvent {
  final String password;
  final String repeatPassword;

  const AuthSetPasswordAdminEvent({required this.password, required this.repeatPassword});
}
