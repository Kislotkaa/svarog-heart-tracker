part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class HistoryInitialEvent extends HistoryEvent {
  const HistoryInitialEvent();
}

class GetHistoryEvent extends HistoryEvent {
  const GetHistoryEvent();
}

class DeleteHistoryEvent extends HistoryEvent {
  const DeleteHistoryEvent();
}
