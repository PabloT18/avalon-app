import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../domain/repository/notification_repository.dart';
import '../sources/local_notifications.dart';
import '../sources/remoteFB/puhs_notifications_fb.dart';

/// A service that stores and retrieves user settings about Push Notifications.
///
/// Maneja los tipos de notifcaciones
/// 1 - Flutter LocalNotifications - LocalPushNotification [LN]
/// 2 - FIrebaseCloudMessgain - RemotePushNotification [RPN]
/// '_remotePushNotification'
class NotficationRepositoryImpl implements NotficationRepository {
  NotficationRepositoryImpl(PushNotificationSourceFCM fcmPushNotificationSource)
      : _remotePushNotification = fcmPushNotificationSource;

  final PushNotificationSourceFCM _remotePushNotification;

  late String? tokenFCM;

  /// Chequea estado de [RPN] y inicia procesos de [LN]
  /// los permiso son manejados con [RPN] permisos otrorgados por el usuario
  /// aplica para los dos tipos
  @override
  Future<AuthorizationStatus> getStatus() async {
    AuthorizationStatus authorizationStatus =
        await _remotePushNotification.statusCheck();

    authorizationStatus = await _remotePushNotification.requestPermission();

    /// Si no estan derminoados los permisos se pide estabelcer al usuairo
    if (authorizationStatus == AuthorizationStatus.notDetermined) {
      authorizationStatus = await _remotePushNotification.requestPermission();

      // return authorizationStatusRequest;
    }

    /// si el estado acutal o despues de pedir perimisos es
    /// [AuthorizationStatus.authorized] hya que esstableceer los metodos de
    /// BACKGORUND
    if (authorizationStatus == AuthorizationStatus.authorized) {
      PushNotificationSourceFCM.setFBListeners();

      tokenFCM = await _remotePushNotification.fcmToken();

      await LocalNotifications.initializedLocalNotifications();

      log("TOKEN FCM: $tokenFCM");
    }

    return authorizationStatus;
  }

  @override
  Future<AuthorizationStatus> toogleStatus(bool request) async {
    if (request) {
      /// Pedir perimsos
      final authorizationStatusRequest =
          await _remotePushNotification.requestPermission();
      // print(authorizationStatusRequest);
      /// si el estado acutal o despues de pedir perimisos es
      /// [AuthorizationStatus.authorized] hya que esstableceer los metodos de
      /// BACKGORUND
      if (authorizationStatusRequest == AuthorizationStatus.authorized) {
        // _fbPushNotification.setFBListeners();
        PushNotificationSourceFCM.setFBListeners();

        tokenFCM = await _remotePushNotification.fcmToken();
        log("TOKEN FCM: $tokenFCM");
      }

      return authorizationStatusRequest;
    } else {
      /// TODO: Quitar permisos
      return AuthorizationStatus.denied;
    }
  }

  @override
  Future<void> subscribeTotopics(List<String> topics) async {
    return await _remotePushNotification.subscribeTotopics(topics);
  }

  // @override
  // Future<void> subscribeTotopics(List<String> topics) async {
  //   await _remotePushNotification.subscribeTotopics(topics);
  // }

  // @override
  // Future<void> ubsubscribeTotopics(List<String> topics) async {
  // await _remotePushNotification.subscribeTotopics(topics);
  // }
}
