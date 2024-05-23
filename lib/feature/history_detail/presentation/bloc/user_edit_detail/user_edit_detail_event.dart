part of 'user_edit_detail_bloc.dart';

abstract class UserEditDetailEvent extends Equatable {
  const UserEditDetailEvent();

  @override
  List<Object?> get props => [];
}

class UserEditDetailInitialEvent extends UserEditDetailEvent {
  final String userId;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;

  const UserEditDetailInitialEvent(this.userId,
      {required this.ageController, required this.heightController, required this.weightController});
}

class UserEditDetailSaveEvent extends UserEditDetailEvent {
  final UserDetailParams detailModel;
  const UserEditDetailSaveEvent(this.detailModel);
}

class UserEditDetailSetGenderEvent extends UserEditDetailEvent {
  final int genderFlag;
  const UserEditDetailSetGenderEvent(this.genderFlag);
}
