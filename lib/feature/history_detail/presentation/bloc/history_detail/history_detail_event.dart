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

class HistoryDetailGetUserEvent extends HistoryDetailEvent {
  const HistoryDetailGetUserEvent();
}

class HistoryDetailLoadMoreEvent extends HistoryDetailEvent {
  const HistoryDetailLoadMoreEvent();
}

class HistoryDetailCalculateCalloryEvent extends HistoryDetailEvent {
  const HistoryDetailCalculateCalloryEvent();
}

class HistoryDetailRefreshEvent extends HistoryDetailEvent {
  const HistoryDetailRefreshEvent();
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
