part of 'intl_cubit.dart';

class IntlState extends Equatable {
  const IntlState({
    this.languageCode = IntlLocales.ru,
  });

  final String languageCode;

  IntlState copyWith({String? languageCode}) => IntlState(
        languageCode: languageCode ?? this.languageCode,
      );

  @override
  List<Object?> get props => [languageCode];
}
