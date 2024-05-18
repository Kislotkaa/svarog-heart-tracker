class UserParams {
  final String id;
  final String? userSettingsId;
  final String? userDetailId;

  final String personName;
  final String deviceName;
  final bool? isAutoConnect;

  UserParams({
    required this.id,
    this.userSettingsId,
    this.userDetailId,
    required this.personName,
    required this.deviceName,
    this.isAutoConnect = false,
  });
}
