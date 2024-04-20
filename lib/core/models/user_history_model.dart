import 'dart:convert';

import 'package:flutter/foundation.dart';

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
    this.createAt,
    this.finishedAt,
  });

  final String id;
  final String userId;
  final List<int> yHeart;
  final int maxHeart;
  final int minHeart;
  final int avgHeart;
  final int redTimeHeart;
  final int orangeTimeHeart;
  final int greenTimeHeart;
  final DateTime? createAt;
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
      createAt: map['createAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createAt']) : null,
      finishedAt: map['finishedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['finishedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserHistoryModel.fromJson(String source) => UserHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserHistoryModel(id: $id, userId: $userId, yHeart: $yHeart, maxHeart: $maxHeart, minHeart: $minHeart, avgHeart: $avgHeart, redTimeHeart: $redTimeHeart, orangeTimeHeart: $orangeTimeHeart, greenTimeHeart: $greenTimeHeart, createAt: $createAt, finishedAt: $finishedAt)';
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
        createAt.hashCode ^
        finishedAt.hashCode;
  }
}
