part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final StateStatus status;
  final String? process;
  final String? errorMessage;
  final String? errorTitle;

  const SplashState.initial() : this._();

  const SplashState._({
    this.status = StateStatus.initial,
    this.process,
    this.errorMessage,
    this.errorTitle,
  });

  SplashState copyWith({
    StateStatus? status,
    String? process,
    String? errorMessage,
    String? errorTitle,
  }) =>
      SplashState._(
        status: status ?? this.status,
        process: process,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  SplashState setToDefault() => const SplashState.initial();

  @override
  List<Object?> get props => [
        status,
        process,
        errorMessage,
        errorTitle,
      ];
}
