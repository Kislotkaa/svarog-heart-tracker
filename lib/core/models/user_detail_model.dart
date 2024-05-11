// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'user_detail_model.g.dart';

@HiveType(typeId: 2)
class UserDetailModel {
  UserDetailModel({
    required this.id,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final int gender;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final double height;
  @HiveField(4)
  final double weight;

  UserDetailModel copyWith({
    String? id,
    int? gender,
    int? age,
    double? height,
    double? weight,
  }) {
    return UserDetailModel(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      id: map['id'] as String,
      gender: map['gender'] as int,
      age: map['age'] as int,
      height: map['height'] as double,
      weight: map['weight'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailModel.fromJson(String source) =>
      UserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetailModel(id: $id, gender: $gender, age: $age, height: $height, weight: $weight)';
  }

  @override
  bool operator ==(covariant UserDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.gender == gender &&
        other.age == age &&
        other.height == height &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^ gender.hashCode ^ age.hashCode ^ height.hashCode ^ weight.hashCode;
  }
}
