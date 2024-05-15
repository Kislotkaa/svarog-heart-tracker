// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:svarog_heart_tracker/core/models/user_settings_model.dart';

class UserSettingsParams {
  UserSettingsParams({required this.id, required this.userId, this.settings});

  final String id;
  final String userId;
  final UserSettingsModel? settings;

  UserSettingsParams copyWith({
    String? id,
    String? userId,
    UserSettingsModel? settings,
  }) {
    return UserSettingsParams(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      settings: settings ?? this.settings,
    );
  }
}
