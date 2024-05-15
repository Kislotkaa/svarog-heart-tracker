// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsModelAdapter extends TypeAdapter<UserSettingsModel> {
  @override
  final int typeId = 3;

  @override
  UserSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingsModel(
      id: fields[0] as String,
      greenZone: fields[1] as int,
      orangeZone: fields[2] as int,
      timeNotification: fields[3] as int,
      notificationEnable: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.greenZone)
      ..writeByte(2)
      ..write(obj.orangeZone)
      ..writeByte(3)
      ..write(obj.timeNotification)
      ..writeByte(4)
      ..write(obj.notificationEnable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
