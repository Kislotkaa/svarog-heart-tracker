// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      userDetailId: fields[1] as String?,
      personName: fields[2] as String,
      deviceName: fields[3] as String,
      isAutoConnect: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userDetailId)
      ..writeByte(2)
      ..write(obj.personName)
      ..writeByte(3)
      ..write(obj.deviceName)
      ..writeByte(4)
      ..write(obj.isAutoConnect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
