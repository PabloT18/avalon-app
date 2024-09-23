import 'dart:developer';

import 'package:cache/cache.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final CacheClient _cache = CacheClient();
  static const String _indexNotificationPreferences =
      ConstHiveBox.kUserNotificationPrefeerences;
  static const String _indexNotificationTopics =
      ConstHiveBox.kUserNotificationTopics;

  /// Chequea estado de [RPN] y inicia procesos de [LN]
  /// los permiso son manejados con [RPN] permisos otrorgados por el usuario
  /// aplica para los dos tipos
  @override
  Future<AuthorizationStatus> getStatus() async {
    try {
      AuthorizationStatus authorizationStatus =
          await _remotePushNotification.statusCheck();

      authorizationStatus = await _remotePushNotification.requestPermission();

      /// Si no estan derminoados los permisos se pide estabelcer al usuairo
      if (authorizationStatus == AuthorizationStatus.notDetermined ||
          authorizationStatus == AuthorizationStatus.denied) {
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

        _setInitStetPrefefrecnes();
      }

      return authorizationStatus;
    } catch (e) {
      return AuthorizationStatus.notDetermined;
    }
  }

  @override
  Future<bool?> getUserActiveNotification() async {
    try {
      return _cache.read(key: _indexNotificationPreferences) as bool?;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AuthorizationStatus> requestPermission() async {
    final authorizationStatusRequest =
        await _remotePushNotification.requestPermission();

    if (authorizationStatusRequest == AuthorizationStatus.authorized) {
      PushNotificationSourceFCM.setFBListeners();
      tokenFCM = await _remotePushNotification.fcmToken();
      await LocalNotifications.initializedLocalNotifications();
      await _remotePushNotification.setAutoInitEnabled(true);

      log("TOKEN FCM: $tokenFCM");
      return authorizationStatusRequest;
    } else {
      openAppSettings();
      return AuthorizationStatus.denied;
    }
  }

  @override
  Future<void> subscribeTotopics(List<String> topics) async {
    _cache.writePrimary(key: _indexNotificationTopics, value: topics);
    return await _remotePushNotification.subscribeTotopics(topics);
  }

  @override
  Future<void> dellFCM() async {
    await _remotePushNotification.dellTokenFCM();
  }

  @override
  Future<void> deactivateNotifiactions() async {
    /// desuscribirse
    final topics = await _cache.read(key: _indexNotificationTopics);
    if (topics != null) {
      await _remotePushNotification.unSubscribeTotopics(topics as List<String>);
    }
    await _cache.writePrimary(key: _indexNotificationPreferences, value: false);
    await _remotePushNotification.setAutoInitEnabled(false);
  }

  @override
  Future<bool> toogleStatus(bool request) async {
    if (request) {
      await _cache.writePrimary(
          key: _indexNotificationPreferences, value: true);
      await _remotePushNotification.setAutoInitEnabled(true);
      final topics = await _cache.read(key: _indexNotificationTopics);
      if (topics != null) {
        await _remotePushNotification.subscribeTotopics(topics as List<String>);
      }
      // await requestPermission();
      return true;
    } else {
      await deactivateNotifiactions();
      return false;
    }
  }

  void _setInitStetPrefefrecnes() async {
    final preferences = await _cache.read(key: _indexNotificationPreferences);

    if (preferences == null) {
      await _cache.writePrimary(
          key: _indexNotificationPreferences, value: true);
    }
  }
}
