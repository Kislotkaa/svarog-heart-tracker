import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  UserModel({
    required this.id,
     
     this.userDetailId,
    required this.personName,
    required this.deviceName,
    this.isAutoConnect = false,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? userDetailId;
  @HiveField(2)
  final String personName;
  @HiveField(3)
  final String deviceName;
  @HiveField(4)
  final bool? isAutoConnect;

  UserModel copyWith({
    String? id,
    String? userDetailId,
    String? personName,
    String? deviceName,
    bool? isAutoConnect,
  }) {
    return UserModel(
      id: id ?? this.id,
      userDetailId: userDetailId,
      personName: personName ?? this.personName,
      deviceName: deviceName ?? this.deviceName,
      isAutoConnect: isAutoConnect ?? this.isAutoConnect,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userDetailId': userDetailId});
    result.addAll({'personName': personName});
    result.addAll({'deviceName': deviceName});
    result.addAll({
      'isAutoConnect': isAutoConnect == null
          ? 0
          : isAutoConnect!
              ? 1
              : 0
    });

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      userDetailId: map['userDetailId'],
      personName: map['personName'] ?? '',
      deviceName: map['deviceName'],
      isAutoConnect: map['isAutoConnect'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, userDetailId: $userDetailId, personName: $personName, deviceName: $deviceName, isAutoConnect: $isAutoConnect)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.userDetailId == userDetailId &&
        other.personName == personName &&
        other.deviceName == deviceName &&
        other.isAutoConnect == isAutoConnect;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userDetailId.hashCode ^ personName.hashCode ^ deviceName.hashCode ^ isAutoConnect.hashCode;
  }
}
