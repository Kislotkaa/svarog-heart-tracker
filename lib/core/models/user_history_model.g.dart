// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHistoryModelAdapter extends TypeAdapter<UserHistoryModel> {
  @override
  final int typeId = 1;

  @override
  UserHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHistoryModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      yHeart: (fields[2] as List).cast<int>(),
      maxHeart: fields[3] as int,
      minHeart: fields[4] as int,
      avgHeart: fields[5] as int,
      redTimeHeart: fields[6] as int,
      orangeTimeHeart: fields[7] as int,
      greenTimeHeart: fields[8] as int,
      calories: fields[9] as double?,
      createAt: fields[10] as DateTime?,
      finishedAt: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserHistoryModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.yHeart)
      ..writeByte(3)
      ..write(obj.maxHeart)
      ..writeByte(4)
      ..write(obj.minHeart)
      ..writeByte(5)
      ..write(obj.avgHeart)
      ..writeByte(6)
      ..write(obj.redTimeHeart)
      ..writeByte(7)
      ..write(obj.orangeTimeHeart)
      ..writeByte(8)
      ..write(obj.greenTimeHeart)
      ..writeByte(9)
      ..write(obj.calories)
      ..writeByte(10)
      ..write(obj.createAt)
      ..writeByte(11)
      ..write(obj.finishedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHistoryModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
