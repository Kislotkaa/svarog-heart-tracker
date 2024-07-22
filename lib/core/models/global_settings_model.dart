// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GlobalSettingsModel {
  final double timeSavedData; // Время после которого сохраняются данные
  final double timeDisconnect; // Время после которого происходит отключение
  final double timeCheckDevice; // Раз во сколько секунд использовать Bluetooth проверять устройства поблизости?
  final int copressSized; // До какого размера сжимать данные графика
  final bool isMigratedHive; // Была ли миграция на Hive

  GlobalSettingsModel({
    this.timeSavedData = 180, // Минимум 10 - Максимум 600
    this.timeDisconnect = 20, // Минимум 10 - Максимум 240
    this.timeCheckDevice = 6, // Минимум 4 - Максимум 30
    this.copressSized = 100,
    this.isMigratedHive = false,
  });

  GlobalSettingsModel copyWith({
    double? timeSavedData,
    double? timeDisconnect,
    double? timeCheckDevice,
    int? copressSized,
    bool? isMigratedHive,
  }) {
    return GlobalSettingsModel(
      timeSavedData: timeSavedData ?? this.timeSavedData,
      timeDisconnect: timeDisconnect ?? this.timeDisconnect,
      timeCheckDevice: timeCheckDevice ?? this.timeCheckDevice,
      copressSized: copressSized ?? this.copressSized,
      isMigratedHive: isMigratedHive ?? this.isMigratedHive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeSavedData': timeSavedData,
      'timeDisconnect': timeDisconnect,
      'timeCheckDevice': timeCheckDevice,
      'copressSized': copressSized,
      'isMigratedHive': isMigratedHive,
    };
  }

  factory GlobalSettingsModel.fromMap(Map<String, dynamic> map) {
    return GlobalSettingsModel(
      timeSavedData: map['timeSavedData'] as double,
      timeDisconnect: map['timeDisconnect'] as double,
      timeCheckDevice: map['timeCheckDevice'] as double,
      copressSized: map['copressSized'] as int,
      isMigratedHive: map['isMigratedHive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GlobalSettingsModel.fromJson(String source) =>
      GlobalSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GlobalSettingsModel(timeSavedData: $timeSavedData, timeDisconnect: $timeDisconnect, timeCheckDevice: $timeCheckDevice, copressSized: $copressSized, isMigratedHive: $isMigratedHive)';
  }

  @override
  bool operator ==(covariant GlobalSettingsModel other) {
    if (identical(this, other)) return true;

    return other.timeSavedData == timeSavedData &&
        other.timeDisconnect == timeDisconnect &&
        other.timeCheckDevice == timeCheckDevice &&
        other.copressSized == copressSized &&
        other.isMigratedHive == isMigratedHive;
  }

  @override
  int get hashCode {
    return timeSavedData.hashCode ^
        timeDisconnect.hashCode ^
        timeCheckDevice.hashCode ^
        copressSized.hashCode ^
        isMigratedHive.hashCode;
  }
}
