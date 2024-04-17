part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSingInEvent extends AuthEvent {
  final String password;

  const AuthSingInEvent({required this.password});
}

class AuthLogOutEvent extends AuthEvent {
  final String password;

  const AuthLogOutEvent({required this.password});
}
