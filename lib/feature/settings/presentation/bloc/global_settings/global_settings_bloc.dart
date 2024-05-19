import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/models/global_settings_model.dart';
import 'package:svarog_heart_tracker/core/service/sharedPreferences/global_settings_service.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';

part 'global_settings_event.dart';
part 'global_settings_state.dart';

class GlobalSettingsBloc extends Bloc<GlobalSettingsEvent, GlobalSettingsState> {
  final GlobalSettingsService globalSettingsService;

  GlobalSettingsBloc({
    required this.globalSettingsService,
  }) : super(const GlobalSettingsState.initial()) {
    on<GlobalSettingsSetToDefaultEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );

        try {
          final settings = await globalSettingsService.setToDefault();
          emit(
            state.copyWith(
              status: StateStatus.success,
              globalSettingsModel: settings,
            ),
          );
        } catch (e, s) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorMessage: e.toString(),
              errorTitle: 'Ошибка',
            ),
          );
          ErrorHandler.getMessage(e, s);
        }
      },
    );
    on<GlobalSettingsUpdateEvent>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: StateStatus.loading,
            errorMessage: null,
            errorTitle: null,
          ),
        );
        try {
          final timeDisconnect = event.timeDisconnect?.round().toDouble();
          final timeSavedData = event.timeSavedData?.round().toDouble();
          final timeCheckDevice = event.timeCheckDevice?.round().toDouble();

          final settings = globalSettingsService.appSettings.copyWith(
            timeDisconnect: timeDisconnect,
            timeSavedData: timeSavedData,
            timeCheckDevice: timeCheckDevice,
          );

          await globalSettingsService.updateSettings(settings);
          emit(
            state.copyWith(
              status: StateStatus.success,
              globalSettingsModel: settings,
            ),
          );
        } catch (e, s) {
          emit(
            state.copyWith(
              status: StateStatus.failure,
              errorMessage: e.toString(),
              errorTitle: 'Ошибка',
            ),
          );
          ErrorHandler.getMessage(e, s);
        }
      },
    );
  }
}
