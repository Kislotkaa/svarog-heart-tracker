part of 'history_detail_bloc.dart';

abstract class HistoryDetailEvent extends Equatable {
  const HistoryDetailEvent();

  @override
  List<Object?> get props => [];
}

class HistoryDetailInitialEvent extends HistoryDetailEvent {
  final String userId;
  final DeviceController? deviceController;

  const HistoryDetailInitialEvent(this.userId, this.deviceController);
}

class HistoryDetailGetHistoryEvent extends HistoryDetailEvent {
  const HistoryDetailGetHistoryEvent();
}

class HistoryDetailDeleteAllEvent extends HistoryDetailEvent {
  const HistoryDetailDeleteAllEvent();
}

class HistoryDetailDeleteEvent extends HistoryDetailEvent {
  final String id;
  const HistoryDetailDeleteEvent(this.id);
}

class HistoryDetailSwitchAutoConnectEvent extends HistoryDetailEvent {
  const HistoryDetailSwitchAutoConnectEvent();
}
