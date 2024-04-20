class UserParams {
  final String id;
  final String personName;
  final String deviceName;
  final bool isAutoConnect;

  UserParams({
    required this.id,
    required this.personName,
    required this.deviceName,
    this.isAutoConnect = false,
  });
}
