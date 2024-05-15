// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_settings_model.g.dart';

@HiveType(typeId: 3)
class UserSettingsModel {
  UserSettingsModel({
    required this.id,
    this.greenZone = 145,
    this.orangeZone = 160,
    this.timeNotification = 10,
    this.notificationEnable = true,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final int greenZone;
  @HiveField(2)
  final int orangeZone;
  @HiveField(3)
  final int timeNotification;
  @HiveField(4)
  final bool notificationEnable;

  UserSettingsModel copyWith({
    String? id,
    int? greenZone,
    int? orangeZone,
    int? timeNotification,
    bool? notificationEnable,
  }) {
    return UserSettingsModel(
      id: id ?? this.id,
      greenZone: greenZone ?? this.greenZone,
      orangeZone: orangeZone ?? this.orangeZone,
      timeNotification: timeNotification ?? this.timeNotification,
      notificationEnable: notificationEnable ?? this.notificationEnable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'greenZone': greenZone,
      'orangeZone': orangeZone,
      'timeNotification': timeNotification,
      'notificationEnable': notificationEnable,
    };
  }

  factory UserSettingsModel.fromMap(Map<String, dynamic> map) {
    return UserSettingsModel(
      id: map['id'] as String,
      greenZone: map['greenZone'] as int,
      orangeZone: map['orangeZone'] as int,
      timeNotification: map['timeNotification'] as int,
      notificationEnable: map['notificationEnable'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingsModel.fromJson(String source) =>
      UserSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSettingsModel(id: $id, greenZone: $greenZone, orangeZone: $orangeZone, timeNotification: $timeNotification, notificationEnable: $notificationEnable)';
  }

  @override
  bool operator ==(covariant UserSettingsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.greenZone == greenZone &&
        other.orangeZone == orangeZone &&
        other.timeNotification == timeNotification &&
        other.notificationEnable == notificationEnable;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        greenZone.hashCode ^
        orangeZone.hashCode ^
        timeNotification.hashCode ^
        notificationEnable.hashCode;
  }
}
