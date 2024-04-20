import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState.initial()) {
    on<SettingsInitialEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );
      },
    );
  }
}
