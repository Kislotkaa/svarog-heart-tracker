import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'user_history_model.g.dart';

@HiveType(typeId: 1)
class UserHistoryModel {
  UserHistoryModel({
    required this.id,
    required this.userId,
    required this.yHeart,
    required this.maxHeart,
    required this.minHeart,
    required this.avgHeart,
    required this.redTimeHeart,
    required this.orangeTimeHeart,
    required this.greenTimeHeart,
    this.calories,
    this.createAt,
    this.finishedAt,
  });
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final List<int> yHeart;
  @HiveField(3)
  final int maxHeart;
  @HiveField(4)
  final int minHeart;
  @HiveField(5)
  final int avgHeart;
  @HiveField(6)
  final int redTimeHeart;
  @HiveField(7)
  final int orangeTimeHeart;
  @HiveField(8)
  final int greenTimeHeart;
  @HiveField(9)
  final double? calories;
  @HiveField(10)
  final DateTime? createAt;
  @HiveField(11)
  final DateTime? finishedAt;

  UserHistoryModel copyWith({
    String? id,
    String? userId,
    List<int>? yHeart,
    int? maxHeart,
    int? minHeart,
    int? avgHeart,
    int? redTimeHeart,
    int? orangeTimeHeart,
    int? greenTimeHeart,
    double? calories,
    DateTime? createAt,
    DateTime? finishedAt,
  }) {
    return UserHistoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      yHeart: yHeart ?? this.yHeart,
      maxHeart: maxHeart ?? this.maxHeart,
      minHeart: minHeart ?? this.minHeart,
      avgHeart: avgHeart ?? this.avgHeart,
      redTimeHeart: redTimeHeart ?? this.redTimeHeart,
      orangeTimeHeart: orangeTimeHeart ?? this.orangeTimeHeart,
      greenTimeHeart: greenTimeHeart ?? this.greenTimeHeart,
      calories: calories,
      createAt: createAt ?? this.createAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'yHeart': yHeart.join(',')});
    result.addAll({'maxHeart': maxHeart});
    result.addAll({'minHeart': minHeart});
    result.addAll({'avgHeart': avgHeart});
    result.addAll({'redTimeHeart': redTimeHeart});
    result.addAll({'orangeTimeHeart': orangeTimeHeart});
    result.addAll({'greenTimeHeart': greenTimeHeart});
    if (calories != null) {
      result.addAll({'calories': calories});
    }
    if (createAt != null) {
      result.addAll({'createAt': createAt!.millisecondsSinceEpoch});
    }
    if (finishedAt != null) {
      result.addAll({'finishedAt': finishedAt!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory UserHistoryModel.fromMap(Map<String, dynamic> map) {
    return UserHistoryModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      yHeart: map['yHeart'].split(',').map(int.parse).cast<int>().toList(),
      maxHeart: map['maxHeart']?.toInt() ?? 0,
      minHeart: map['minHeart']?.toInt() ?? 0,
      avgHeart: map['avgHeart']?.toInt() ?? 0,
      redTimeHeart: map['redTimeHeart']?.toInt() ?? 0,
      orangeTimeHeart: map['orangeTimeHeart']?.toInt() ?? 0,
      greenTimeHeart: map['greenTimeHeart']?.toInt() ?? 0,
      calories: map['calories'] != null ? map['calories'] as double : null,
      createAt: map['createAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createAt']) : null,
      finishedAt: map['finishedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['finishedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserHistoryModel.fromJson(String source) => UserHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserHistoryModel(id: $id, userId: $userId, yHeart: $yHeart, maxHeart: $maxHeart, minHeart: $minHeart, avgHeart: $avgHeart, redTimeHeart: $redTimeHeart, orangeTimeHeart: $orangeTimeHeart, greenTimeHeart: $greenTimeHeart, calories: $calories, createAt: $createAt, finishedAt: $finishedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserHistoryModel &&
        other.id == id &&
        other.userId == userId &&
        listEquals(other.yHeart, yHeart) &&
        other.maxHeart == maxHeart &&
        other.minHeart == minHeart &&
        other.avgHeart == avgHeart &&
        other.redTimeHeart == redTimeHeart &&
        other.orangeTimeHeart == orangeTimeHeart &&
        other.greenTimeHeart == greenTimeHeart &&
        other.calories == calories &&
        other.createAt == createAt &&
        other.finishedAt == finishedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        yHeart.hashCode ^
        maxHeart.hashCode ^
        minHeart.hashCode ^
        avgHeart.hashCode ^
        redTimeHeart.hashCode ^
        orangeTimeHeart.hashCode ^
        greenTimeHeart.hashCode ^
        calories.hashCode ^
        createAt.hashCode ^
        finishedAt.hashCode;
  }
}
