import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:svarog_heart_tracker/core/constant/enums.dart';
import 'package:svarog_heart_tracker/core/usecase/usecase.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  /// **[NoParams]** required

  UserSettingsBloc() : super(const UserSettingsState.initial()) {
    on<UserSettingsInitEvent>((event, emit) async {});
  }
}
