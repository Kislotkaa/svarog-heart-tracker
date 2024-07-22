part of 'auto_connect_bloc.dart';

class AutoConnectState extends Equatable {
  final StateStatus status;
  final String? errorMessage;
  final String? errorTitle;
  final List<UserModel> users;
  final List<ScanResult> scanResult;

  const AutoConnectState.initial() : this._();

  const AutoConnectState._({
    this.status = StateStatus.initial,
    this.users = const [],
    this.scanResult = const [],
    this.errorMessage,
    this.errorTitle,
  });

  AutoConnectState copyWith({
    StateStatus? status,
    List<UserModel>? users,
    List<ScanResult>? scanResult,
    String? errorMessage,
    String? errorTitle,
  }) =>
      AutoConnectState._(
        status: status ?? this.status,
        users: users ?? this.users,
        scanResult: scanResult ?? this.scanResult,
        errorMessage: errorMessage,
        errorTitle: errorTitle,
      );

  AutoConnectState setToDefault() => const AutoConnectState.initial();

  @override
  List<Object?> get props => [
        status,
        users,
        scanResult,
        errorMessage,
        errorTitle,
      ];
}
