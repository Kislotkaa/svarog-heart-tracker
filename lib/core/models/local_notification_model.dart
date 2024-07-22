class LocalNotificationModel {
  final String title;
  final String description;
  final String? link;

  LocalNotificationModel({
    required this.title,
    required this.description,
    this.link,
  });
}
