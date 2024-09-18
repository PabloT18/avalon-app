import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../domain/entity/push_notifications/push_message.dart';
import '../../models/push_notifications/push_message_model.dart';

class PushNotificationSourceFCM {
  PushNotificationSourceFCM() {
    _fbMessaging = FirebaseMessaging.instance;
  }

  late FirebaseMessaging _fbMessaging;

  // static FirebaseMessaging _fbMessaging = FirebaseMessaging.instance;

  /// Devuelve el estoado de los permisos para recibir notificaciones
  Future<AuthorizationStatus> statusCheck() async {
    final settings = await _fbMessaging.getNotificationSettings();
    return settings.authorizationStatus;
  }

  Future<AuthorizationStatus> requestPermission() async {
    NotificationSettings settings = await _fbMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User puhs notifications status ${settings.authorizationStatus}');

    return settings.authorizationStatus;
  }

  Future<void> setAutoInitEnabled(bool state) async {
    await _fbMessaging.setAutoInitEnabled(state);
  }

  Future<void> dellTokenFCM() async {
    await _fbMessaging.deleteToken();
  }

  // Obtiene el token de FCM
  Future<String?> fcmToken() async => await _fbMessaging.getToken();

  Future<void> subscribeTotopics(List<String> topics) async {
    for (var topic in topics) {
      await _fbMessaging.subscribeToTopic(topic);
    }
  }

  Future<void> unSubscribeTotopics(List<String> topics) async {
    for (var topic in topics) {
      await _fbMessaging.unsubscribeFromTopic(topic);
    }
  }

  static void setFBListeners() {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onsMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  /// Strean Controller el cual escuhcara todos los mensajes establecidos en
  /// metodos Background
  static final StreamController<PushMessage> _messageStream =
      StreamController<PushMessage>.broadcast();
  // static final StreamController<RemoteMessage> _messageStream =
  //     StreamController<RemoteMessage>.broadcast();

  static Stream<PushMessage> get messagesStream => _messageStream.stream;
  // static Stream<RemoteMessage> get messagesStream => _messageStream.stream;

  /// Metodos staticos  Listener de background de Firebase Mesagging que
  ///  adicionan al StreamController<RemoteMessage> _messageStream cada mensaje
  /// que controlen
  ///
  /// [1]
  static Future _backgroundHandler(RemoteMessage message) async {
    // log("On background onTerminateApp message: ${message.data}");
    if (message.notification != null) {
      _messageStream.add(PushMessageModel.fromRemoteMessage(
          message, NotificationMessageType.onTerminateApp));
    }
  }

  /// [2] Mesages que llegan si la palicacion esta abierta
  static Future _onsMessageHandler(RemoteMessage message) async {
    // log("On app opended message: ${message.data}");
    if (message.notification != null) {
      _messageStream.add(PushMessageModel.fromRemoteMessage(
          message, NotificationMessageType.onOpenApp));
    }
  }

  /// [2] Mesages que llegan si la palicacion esta suspendida y se abre la app
  /// desde la notificacion
  static Future _onMessageOpenApp(RemoteMessage message) async {
    // log("On background onSuspendApp message: ${message.data}");
    if (message.notification != null) {
      _messageStream.add(PushMessageModel.fromRemoteMessage(
          message, NotificationMessageType.onSuspendApp));
    }
  }
}

// OnePlus8 token
// dqt55-ipSEKbcfRR04jppa:APA91bFZpGx18l0YVDOjT4X04mrrxKaqpZavWBaaIhvlj7_PM5sfXHwxZBFGp1Yfbthmcqd-6OizbjnBu8k1FsXh7egRyn7oRf5B63LkSxVsnmShLJJnapZHgCGOp4oRU5CVtM34w6mc
