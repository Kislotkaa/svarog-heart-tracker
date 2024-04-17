import 'dart:convert';

class StartAppModel {
  StartAppModel({
    required this.isFirstStart,
    required this.isHaveAuth,
    this.localPassword,
  });

  final bool isFirstStart;
  final bool isHaveAuth;
  final String? localPassword;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isFirstStart': isFirstStart});
    result.addAll({'isHaveAuth': isHaveAuth});
    if (localPassword != null) {
      result.addAll({'localPassword': localPassword});
    }

    return result;
  }

  factory StartAppModel.fromMap(Map<String, dynamic> map) {
    return StartAppModel(
      isFirstStart: map['isFirstStart'] ?? false,
      isHaveAuth: map['isHaveAuth'] ?? false,
      localPassword: map['localPassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StartAppModel.fromJson(String source) => StartAppModel.fromMap(json.decode(source));

  StartAppModel copyWith({
    bool? isFirstStart,
    bool? isHaveAuth,
    String? localPassword,
  }) {
    return StartAppModel(
      isFirstStart: isFirstStart ?? this.isFirstStart,
      isHaveAuth: isHaveAuth ?? this.isHaveAuth,
      localPassword: localPassword ?? this.localPassword,
    );
  }

  @override
  String toString() =>
      'StartAppModel(isFirstStart: $isFirstStart, isHaveAuth: $isHaveAuth, localPassword: $localPassword)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StartAppModel &&
        other.isFirstStart == isFirstStart &&
        other.isHaveAuth == isHaveAuth &&
        other.localPassword == localPassword;
  }

  @override
  int get hashCode => isFirstStart.hashCode ^ isHaveAuth.hashCode ^ localPassword.hashCode;
}
