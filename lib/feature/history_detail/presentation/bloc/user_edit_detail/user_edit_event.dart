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

  const UserEditInitialEvent(this.userId,
      {required this.ageController, required this.heightController, required this.weightController});
}

class UserEditSaveEvent extends UserEditEvent {
  final UserDetailParams detailModel;

  const UserEditSaveEvent({required this.detailModel});
}

class UserEditSetGenderEvent extends UserEditEvent {
  final int genderFlag;
  const UserEditSetGenderEvent(this.genderFlag);
}
