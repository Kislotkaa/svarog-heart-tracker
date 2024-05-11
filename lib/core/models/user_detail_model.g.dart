// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailModelAdapter extends TypeAdapter<UserDetailModel> {
  @override
  final int typeId = 2;

  @override
  UserDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetailModel(
      id: fields[0] as String,
      gender: fields[1] as int,
      age: fields[2] as int,
      height: fields[3] as double,
      weight: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetailModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
