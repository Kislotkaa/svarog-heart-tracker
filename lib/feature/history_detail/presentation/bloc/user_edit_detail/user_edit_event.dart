part of 'user_edit_bloc.dart';

abstract class UserEditEvent extends Equatable {
  const UserEditEvent();

  @override
  List<Object?> get props => [];
}

class UserEditInitialEvent extends UserEditEvent {
  final String userId;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController greenZoneController;
  final TextEditingController orangeZoneController;

  const UserEditInitialEvent(
    this.userId, {
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.greenZoneController,
    required this.orangeZoneController,
  });
}

class UserSaveEvent extends UserEditEvent {
  final UserDetailParams detailParams;
  final UserSettingsParams settingsParams;

  const UserSaveEvent({required this.detailParams, required this.settingsParams});
}

class UserSaveGenderEvent extends UserEditEvent {
  final int genderFlag;
  const UserSaveGenderEvent(this.genderFlag);
}
