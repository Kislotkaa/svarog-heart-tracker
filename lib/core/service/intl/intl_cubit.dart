import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svarog_heart_tracker/core/constant/constants.dart';
import 'package:svarog_heart_tracker/core/service/intl/repository/intl_repository.dart';

part 'intl_state.dart';

class IntlCubit extends Cubit<IntlState> {
  final IntlRepository _intlRepository;

  IntlCubit({
    required IntlRepository intlRepository,
  })  : _intlRepository = intlRepository,
        super(const IntlState()) {
    // initialize subscription
    getCurrentLocale();
  }

  late StreamSubscription<String> _localeSubscription;

  void getCurrentLocale() {
    // Listen if locale changed in preferences
    _localeSubscription = _intlRepository.getLocale().listen(
      (locale) {
        emit(state.copyWith(languageCode: locale));
      },
    );
  }

  void changeLocale(String languageCode) {
    if (languageCode == state.languageCode) {
      return;
    }

    // We don't need to emit state here.
    // It will be set in getCurrentLocale function because of Stream
    _intlRepository.saveLocale(languageCode);
  }

  @override
  Future<void> close() {
    _localeSubscription.cancel();
    _intlRepository.dispose();
    return super.close();
  }
}
