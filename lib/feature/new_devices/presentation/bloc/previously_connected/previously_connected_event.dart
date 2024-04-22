part of 'previously_connected_bloc.dart';

abstract class PreviouslyConnectedEvent extends Equatable {
  const PreviouslyConnectedEvent();

  @override
  List<Object?> get props => [];
}

class PreviouslyConnectedGetUsersEvent extends PreviouslyConnectedEvent {
  const PreviouslyConnectedGetUsersEvent();
}
