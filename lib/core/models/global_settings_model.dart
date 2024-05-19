// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GlobalSettingsModel {
  final double timeSavedData; // Время после которого сохраняются данные
  final double timeDisconnect; // Время после которого происходит отключение
  final bool isMigratedHive;

  GlobalSettingsModel({
    this.timeSavedData = 180,
    this.timeDisconnect = 20,
    this.isMigratedHive = false,
  });

  GlobalSettingsModel copyWith({
    double? timeSavedData,
    double? timeDisconnect,
    bool? isMigratedHive,
  }) {
    return GlobalSettingsModel(
      timeSavedData: timeSavedData ?? this.timeSavedData,
      timeDisconnect: timeDisconnect ?? this.timeDisconnect,
      isMigratedHive: isMigratedHive ?? this.isMigratedHive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeSavedData': timeSavedData,
      'timeDisconnect': timeDisconnect,
      'isMigratedHive': isMigratedHive,
    };
  }

  factory GlobalSettingsModel.fromMap(Map<String, dynamic> map) {
    return GlobalSettingsModel(
      timeSavedData: map['timeSavedData'] as double,
      timeDisconnect: map['timeDisconnect'] as double,
      isMigratedHive: map['isMigratedHive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GlobalSettingsModel.fromJson(String source) =>
      GlobalSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GlobalSettingsModel(timeSavedData: $timeSavedData, timeDisconnect: $timeDisconnect, isMigratedHive: $isMigratedHive)';

  @override
  bool operator ==(covariant GlobalSettingsModel other) {
    if (identical(this, other)) return true;

    return other.timeSavedData == timeSavedData &&
        other.timeDisconnect == timeDisconnect &&
        other.isMigratedHive == isMigratedHive;
  }

  @override
  int get hashCode => timeSavedData.hashCode ^ timeDisconnect.hashCode ^ isMigratedHive.hashCode;
}
