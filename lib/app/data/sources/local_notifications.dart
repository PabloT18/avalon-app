import 'package:avalon_app/app/data/models/push_notifications/push_message_model.dart';
import 'package:avalon_app/core/config/router/app_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  static Future<void> initializedLocalNotifications() async {
    final flutterLNPLugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('push_icon');

    const initializationSettingsDarwinIos = DarwinInitializationSettings(
      onDidReceiveLocalNotification: showLocalNotification,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwinIos,
    );

    await flutterLNPLugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  /// Al abrir una LocalNotification creaos una inssancia de [PushMessageModel]
  /// basada de NotificationResponse
  /// Si PushMessageModel tiene ruta, esta navega.
  static void _onDidReceiveNotificationResponse(NotificationResponse message) {
    // AppRouter.router.push(location)
    final pushMessgae = PushMessageModel.fromLocalNotificationResponse(message);

    if (pushMessgae.hasRoute) {
      AppRouter.navigateFromPushMessage(pushMessgae);
    }
  }

  static void showLocalNotification(
      int id, String? title, String? body, String? data) {
    const androidDetails = AndroidNotificationDetails(
      'local_channel_id', // Asegúrate de usar un ID de canal diferente
      'Local Notifications',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(
      id, title, body, notificationDetails,
      // payload: data.toString()
      payload: data != null
          ? '{"isLocal": true, "data": $data}'
          : '{"isLocal": true}',
    );
  }
}
