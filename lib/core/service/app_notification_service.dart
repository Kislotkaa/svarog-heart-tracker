import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:svarog_heart_tracker/core/cubit/theme_cubit/theme_cubit.dart';
import 'package:svarog_heart_tracker/core/models/local_notification_model.dart';
import 'package:svarog_heart_tracker/core/utils/error_handler.dart';

FlutterLocalNotificationsPlugin? localNotification;

AndroidNotificationChannel get androidNotificationChannel => const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

class AppNotificationService {
  late bool _isAccessAllowed = false;
  late bool _isLocalEnable = true;

  bool get isEnable => _isAccessAllowed && _isLocalEnable ? true : false;

  Future<void> init() async {
    try {
      if (localNotification != null) return;

      localNotification = FlutterLocalNotificationsPlugin();

      await localNotification
          ?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidNotificationChannel);

      await localNotification
          ?.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );

      await localNotification?.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@drawable/ic_notification'),
          iOS: DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
          ),
        ),
        onDidReceiveNotificationResponse: _onTapNotification,
        onDidReceiveBackgroundNotificationResponse: _onTapNotification,
      );

      final isEnableAndroid = await localNotification
          ?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      final isEnableIos = await localNotification
          ?.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions();

      if (Platform.isAndroid) {
        _isAccessAllowed = isEnableAndroid ?? false;
        log("Notification Android is: $isEnableAndroid");
        return;
      }

      if (Platform.isIOS) {
        _isAccessAllowed = isEnableIos ?? false;
        log("Notification Ios is: $isEnableIos");
        return;
      }
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  Future<void> showNotification(LocalNotificationModel model) async {
    try {
      await localNotification?.show(
        model.hashCode,
        model.title,
        model.description,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'svarog_notification_channel',
            'svarog_notification_channel',
            playSound: true,
            indeterminate: true,
            importance: Importance.max,
            priority: Priority.max,
            color: appTheme.primaryColor,
          ),
        ),
        payload: model.link != null ? '{"link": "${model.link}"}' : null,
      );
    } catch (e, s) {
      ErrorHandler.getMessage(e, s);
    }
  }

  void switchLocalEnable(bool flag) => _isLocalEnable = flag;
}

@pragma('vm:entry-point')
void _onTapNotification(NotificationResponse response) async {
  if (response.payload?.isNotEmpty != true) return;
  final Map<String, dynamic> data = jsonDecode(response.payload!);

  log(data['link']);
}
