import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.personName,
    required this.deviceName,
    this.isAutoConnect = false,
  });

  final String id;
  final String personName;
  final String deviceName;
  final bool? isAutoConnect;

  UserModel copyWith({
    String? id,
    String? personName,
    String? deviceName,
    bool? isAutoConnect,
  }) {
    return UserModel(
      id: id ?? this.id,
      personName: personName ?? this.personName,
      deviceName: deviceName ?? this.deviceName,
      isAutoConnect: isAutoConnect ?? this.isAutoConnect,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
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
      personName: map['personName'] ?? '',
      deviceName: map['deviceName'],
      isAutoConnect: map['isAutoConnect'] == 1 ? true : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, personName: $personName, deviceName: $deviceName, isAutoConnect: $isAutoConnect)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.personName == personName &&
        other.deviceName == deviceName &&
        other.isAutoConnect == isAutoConnect;
  }

  @override
  int get hashCode {
    return id.hashCode ^ personName.hashCode ^ deviceName.hashCode ^ isAutoConnect.hashCode;
  }
}
